#!/usr/bin/env bash
# turbot-events.sh - manage SQS triggers for all Lambda functions
# matching a given Turbot Enterprise (TE) version prefix.
#
# Disabling the triggers pauses Guardrails event processing (events queue in
# SQS); enabling them resumes processing. Typically used to quiesce a
# workspace around a maintenance window or database migration.
#
# Requires: aws (CLI v1 or v2), jq
#
# Usage:
#   ./turbot-events.sh <te-version> <enable|disable|status> [--profile <profile>] [--region <region>]
#
# Examples:
#   ./turbot-events.sh 5.55.0 status  --profile my-hosting-profile
#   ./turbot-events.sh 5.55.0 disable --profile my-hosting-profile
#   ./turbot-events.sh 5.55.0 enable  --profile my-hosting-profile --region us-east-2

set -euo pipefail

# -- helpers -------------------------------------------------------------------

usage() {
    echo "Usage: $0 <te-version> <enable|disable|status> [--profile <profile>] [--region <region>]"
    echo ""
    echo "  status   show current trigger state for all matching Lambda functions"
    echo "  disable  disable all SQS triggers (pause event processing)"
    echo "  enable   enable all SQS triggers (resume event processing)"
    echo ""
    echo "Example: $0 5.55.0 disable --profile my-hosting-profile"
    exit 1
}

info()   { echo "  $*"; }
ok()     { echo "  ✓ $*"; }
skip()   { echo "  - $*"; }
warn()   { echo "  ⚠ $*"; }
header() { echo; echo "▶ $*"; }

# pad state names so the status table columns line up
state_label() {
    local s="$1"
    case "$s" in
        Enabled)   echo "Enabled  " ;;
        Disabled)  echo "Disabled " ;;
        Enabling)  echo "Enabling…" ;;
        Disabling) echo "Disabling…" ;;
        Updating)  echo "Updating…" ;;
        *)         echo "$s" ;;
    esac
}

# -- prerequisites -------------------------------------------------------------

for cmd in aws jq; do
    command -v "$cmd" >/dev/null 2>&1 || {
        echo "Error: required command '$cmd' not found in PATH" >&2
        exit 1
    }
done

# -- argument parsing ----------------------------------------------------------

[[ $# -lt 2 ]] && usage

VERSION="$1"
ACTION="$2"
shift 2

CLI=()

while [[ $# -gt 0 ]]; do
    case "$1" in
        --profile) CLI+=(--profile "$2"); shift 2 ;;
        --region)  CLI+=(--region "$2");  shift 2 ;;
        -h|--help) usage ;;
        *) echo "Unknown option: $1"; usage ;;
    esac
done

if [[ "$ACTION" != "enable" && "$ACTION" != "disable" && "$ACTION" != "status" ]]; then
    echo "Error: action must be 'enable', 'disable', or 'status'"
    usage
fi

# -- derive prefix: 5.55.0 -> turbot_5_55_0 ------------------------------------

PREFIX="turbot_$(echo "$VERSION" | tr '.' '_')"

echo "=================================================="
echo " Turbot Events: $(echo "$ACTION" | tr '[:lower:]' '[:upper:]')"
echo "=================================================="
echo " TE version    : $VERSION"
echo " Lambda prefix : $PREFIX"
echo " Action        : $ACTION"
echo "=================================================="

# -- discover matching Lambda functions (auto-paginated) ------------------------

header "Discovering Lambda functions with prefix '$PREFIX'..."

FUNCTIONS=$(aws lambda list-functions "${CLI[@]}" --output json \
    | jq -r --arg p "$PREFIX" \
        '.Functions[] | select(.FunctionName | startswith($p)) | .FunctionName' \
    | sort)

if [[ -z "$FUNCTIONS" ]]; then
    echo "  No Lambda functions found with prefix '$PREFIX'. Exiting."
    exit 1
fi

FUNC_COUNT=$(echo "$FUNCTIONS" | wc -l | tr -d ' ')
echo "  Found $FUNC_COUNT function(s):"
echo "$FUNCTIONS" | awk '{print "    " NR". "$1}'

# -- helper: fetch all event source mappings for a function ----------------------
# Manual --marker pagination keeps this correct on both AWS CLI v1 (no
# auto-pagination) and v2 (auto-paginated; NextMarker never appears, so the
# loop runs once).

get_mappings() {
    local func="$1"
    local all="[]"
    local next_marker=""
    while true; do
        local marker_arg=()
        [[ -n "$next_marker" ]] && marker_arg=(--marker "$next_marker")

        local page
        page=$(aws lambda list-event-source-mappings "${CLI[@]}" \
            --function-name "$func" "${marker_arg[@]}" --output json)

        all=$(printf '%s\n%s' "$all" "$page" \
            | jq -s '.[0] + .[1].EventSourceMappings')

        next_marker=$(echo "$page" | jq -r '.NextMarker // empty')
        [[ -z "$next_marker" ]] && break
    done
    echo "$all"
}

# -- status ----------------------------------------------------------------------

if [[ "$ACTION" == "status" ]]; then
    header "Current trigger states"
    printf "\n  %-50s  %-35s  %s\n" "FUNCTION" "QUEUE" "STATE"
    printf "  %-50s  %-35s  %s\n" \
        "--------------------------------------------------" \
        "-----------------------------------" \
        "---------"

    ALL_ENABLED=0
    ALL_DISABLED=0
    ALL_OTHER=0

    while IFS= read -r FUNC; do
        MAPPINGS=$(get_mappings "$FUNC")
        COUNT=$(echo "$MAPPINGS" | jq 'length')

        if [[ "$COUNT" -eq 0 ]]; then
            printf "  %-50s  %-35s  %s\n" "$FUNC" "(no mappings)" "-"
            continue
        fi

        while IFS= read -r M; do
            STATE=$(echo "$M"  | jq -r '.state')
            SOURCE=$(echo "$M" | jq -r '.source')
            printf "  %-50s  %-35s  %s\n" "$FUNC" "$SOURCE" "$(state_label "$STATE")"

            case "$STATE" in
                Enabled)  ALL_ENABLED=$((ALL_ENABLED + 1))  ;;
                Disabled) ALL_DISABLED=$((ALL_DISABLED + 1)) ;;
                *)        ALL_OTHER=$((ALL_OTHER + 1))       ;;
            esac
        done < <(echo "$MAPPINGS" | jq -c '.[] | {
            state:  .State,
            source: (.EventSourceArn | split(":") | last)
        }')

    done <<< "$FUNCTIONS"

    echo
    echo "=================================================="
    echo " Status Summary"
    echo "=================================================="
    echo " Functions        : $FUNC_COUNT"
    echo " Enabled          : $ALL_ENABLED"
    echo " Disabled         : $ALL_DISABLED"
    [[ $ALL_OTHER -gt 0 ]] && echo " Transitioning    : $ALL_OTHER ⚠"
    echo "=================================================="
    exit 0
fi

# -- enable / disable -------------------------------------------------------------

TOTAL_MAPPINGS=0
UPDATED=0
SKIPPED=0
ERRORS=0

[[ "$ACTION" == "enable" ]] && ENABLED_FLAG="--enabled" || ENABLED_FLAG="--no-enabled"
TARGET_STATE=$([ "$ACTION" = "enable" ] && echo "Enabled" || echo "Disabled")

while IFS= read -r FUNC; do
    header "$FUNC"

    MAPPINGS=$(get_mappings "$FUNC")
    COUNT=$(echo "$MAPPINGS" | jq 'length')

    if [[ "$COUNT" -eq 0 ]]; then
        skip "no event source mappings, skipping"
        continue
    fi

    while IFS= read -r MAPPING; do
        UUID=$(echo "$MAPPING"   | jq -r '.uuid')
        STATE=$(echo "$MAPPING"  | jq -r '.state')
        SOURCE=$(echo "$MAPPING" | jq -r '.source')
        TOTAL_MAPPINGS=$((TOTAL_MAPPINGS + 1))

        # already in target state
        if [[ "$STATE" == "$TARGET_STATE" ]]; then
            skip "$SOURCE: already $(echo "$STATE" | tr '[:upper:]' '[:lower:]'), no change needed"
            SKIPPED=$((SKIPPED + 1))
            continue
        fi

        # in-flight: skip
        if [[ "$STATE" == "Enabling" || "$STATE" == "Disabling" || "$STATE" == "Updating" ]]; then
            warn "$SOURCE: in transient state '$STATE', skipping (retry later)"
            SKIPPED=$((SKIPPED + 1))
            continue
        fi

        info "$SOURCE: $STATE → $TARGET_STATE (applying...)"

        RESPONSE=$(aws lambda update-event-source-mapping "${CLI[@]}" \
            --uuid "$UUID" $ENABLED_FLAG --output json 2>&1) && RC=0 || RC=$?

        if [[ $RC -ne 0 ]]; then
            warn "FAILED: $RESPONSE"
            ERRORS=$((ERRORS + 1))
            continue
        fi

        # report the state AWS returned (may be transitional e.g. "Disabling")
        APPLIED_STATE=$(echo "$RESPONSE" | jq -r '.State')
        ok "$SOURCE: confirmed → $APPLIED_STATE"
        UPDATED=$((UPDATED + 1))

    done < <(echo "$MAPPINGS" | jq -c '.[] | {
        uuid:   .UUID,
        state:  .State,
        source: (.EventSourceArn | split(":") | last)
    }')

done <<< "$FUNCTIONS"

# -- summary -----------------------------------------------------------------------

echo
echo "=================================================="
echo " Summary"
echo "=================================================="
echo " Functions found   : $FUNC_COUNT"
echo " Mappings found    : $TOTAL_MAPPINGS"
echo " Updated           : $UPDATED"
echo " Skipped (no-op)   : $SKIPPED"
[[ $ERRORS -gt 0 ]] && echo " Errors            : $ERRORS ⚠"
echo " Action            : $(echo "$ACTION" | tr '[:lower:]' '[:upper:]')"
echo "=================================================="

if [[ $UPDATED -gt 0 ]]; then
    echo
    echo " Note: trigger state changes are async. Run 'status' to confirm"
    echo " final state once AWS completes the transition."
    echo "=================================================="
fi

[[ $ERRORS -gt 0 ]] && exit 2 || exit 0
