#!/usr/bin/env bash
# turbot-events.sh - pause and resume Guardrails event processing for one or
# more Turbot Enterprise (TE) versions. It works for both worker runtimes:
#
#   Lambda   The SQS triggers (event source mappings) of the TE's Lambda
#            functions are disabled or enabled.
#   Fargate  The ECS worker services (<prefix>_<version>_worker_*_fg) are scaled
#            to 0 and back. Their desired count and autoscaling bounds are saved
#            in service tags (turbot-events-pause:*) before they are changed,
#            and are restored on 'enable'.
#
# The runtime is found per version. A Fargate TE keeps its Lambda functions, but
# the triggers for the queues that Fargate serves stay Disabled. 'enable' never
# turns those back on (that would run both runtimes on the same queues). The
# Lambda triggers that always stay on Lambda (retry, osquery, DLQs) are handled
# as before.
#
# Disabling pauses Guardrails event processing (events queue in SQS); enabling
# resumes processing. Typically used to quiesce a workspace around a
# maintenance window or database migration.
#
# Several versions can be given as a comma-separated list. The Lambda function
# list is fetched once, then trigger lookups and updates run in parallel.
# Everything is read first. If any read fails, nothing is changed.
#
# Requires: aws (CLI v1 or v2), jq
# IAM:      lambda:ListFunctions, lambda:ListEventSourceMappings,
#           lambda:UpdateEventSourceMapping (enable/disable)
#           ecs:ListServices, ecs:DescribeServices, ecs:DescribeTaskDefinition,
#           ecs:ListTagsForResource, application-autoscaling:DescribeScalableTargets
#           ecs:UpdateService, ecs:TagResource, ecs:UntagResource,
#           application-autoscaling:RegisterScalableTarget (enable/disable)
#
# Usage:
#   ./turbot-events.sh <te-version[,te-version...]> <enable|disable|status> \
#       [--profile <profile>] [--region <region>] [--prefix <name>] \
#       [--cluster <name>] [--lambda-only] [--dry-run] [--jobs <n>]
#
# A version maps to the Lambda name prefix <name>_<version>_, for example
# 5.60.12 -> turbot_5_60_12_ and 5.61.0-rc.10 -> turbot_5_61_0_rc_10_.
# A stable version never matches its release candidates (5.61.0 skips
# turbot_5_61_0_rc_*). Use --prefix for installs named differently
# (default: turbot). The ECS cluster is named after the prefix unless
# --cluster says otherwise.
#
# Examples:
#   ./turbot-events.sh 5.55.0 status  --profile my-hosting-profile
#   ./turbot-events.sh 5.55.0 disable --profile my-hosting-profile --dry-run
#   ./turbot-events.sh 5.60.12,5.60.14,5.60.16 enable --profile my-hosting-profile --region us-east-2
#   ./turbot-events.sh 5.60.12 status --profile my-hosting-profile --prefix myturbot
#   ./turbot-events.sh 5.60.17,5.61.0-rc.10 status --profile my-hosting-profile
#   ./turbot-events.sh 5.61.0-rc.16 disable --profile my-hosting-profile --region us-gov-west-1

set -euo pipefail

# bash counts seconds since this point; read by elapsed() for the summary
SECONDS=0

DEFAULT_JOBS=8
MAX_JOBS=16
DEFAULT_NAME_PREFIX=turbot

# Service tags that hold the values saved by 'disable' for Fargate worker
# services. Allowed tag characters: letters, digits, space and + - = . _ : / @
TAG_DESIRED="turbot-events-pause:desired"
TAG_MIN="turbot-events-pause:autoscaling-min"
TAG_MAX="turbot-events-pause:autoscaling-max"

# -- helpers -------------------------------------------------------------------

usage() {
    echo "Usage: $0 <te-version[,te-version...]> <enable|disable|status> [--profile <profile>] [--region <region>] [--prefix <name>] [--cluster <name>] [--lambda-only] [--dry-run] [--jobs <n>]"
    echo ""
    echo "  status      show the runtime and trigger/service state of each TE version"
    echo "  disable     pause event processing (Lambda: disable SQS triggers; Fargate: scale workers to 0)"
    echo "  enable      resume event processing (Lambda: enable SQS triggers; Fargate: restore saved scale)"
    echo ""
    echo "  --prefix <name>   Lambda name prefix (default: $DEFAULT_NAME_PREFIX); 5.60.12 matches <name>_5_60_12_*"
    echo "  --cluster <name>  ECS cluster that runs the Fargate workers (default: the prefix)"
    echo "  --lambda-only     do not look at ECS at all (no ECS permissions needed). Fargate workers are"
    echo "                    NOT paused, and 'enable' would turn on Lambda triggers that Fargate serves."
    echo "                    Use only on a TE that has no Fargate workers."
    echo "  --dry-run         enable/disable only: show what would change, change nothing"
    echo "  --jobs <n>        parallel AWS calls (default $DEFAULT_JOBS, max $MAX_JOBS)"
    echo ""
    echo "Examples:"
    echo "  $0 5.55.0 disable --profile my-hosting-profile --dry-run"
    echo "  $0 5.60.12,5.60.14,5.60.16 enable --profile my-hosting-profile"
    echo "  $0 5.60.12 status --profile my-hosting-profile --prefix myturbot"
    echo "  $0 5.61.0-rc.16 disable --profile my-hosting-profile --region us-gov-west-1"
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

# total run time so far, e.g. "45s" or "1m17s"
elapsed() {
    if (( SECONDS >= 60 )); then
        printf '%dm%02ds' $((SECONDS / 60)) $((SECONDS % 60))
    else
        printf '%ds' "$SECONDS"
    fi
}

# join_by <separator> <items...>
join_by() {
    local sep="$1" out="" first=1 x
    shift
    for x in "$@"; do
        if [[ $first -eq 1 ]]; then out="$x"; first=0; else out="$out$sep$x"; fi
    done
    printf '%s' "$out"
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

VERSIONS_ARG="$1"
ACTION="$2"
shift 2

CLI=()
DRY_RUN=0
JOBS=$DEFAULT_JOBS
NAME_PREFIX=$DEFAULT_NAME_PREFIX
CLUSTER=""
LAMBDA_ONLY=0

need_value() { [[ $# -ge 2 ]] || { echo "Error: $1 needs a value"; usage; }; }

while [[ $# -gt 0 ]]; do
    case "$1" in
        --profile) need_value "$@"; CLI+=(--profile "$2"); shift 2 ;;
        --region)  need_value "$@"; CLI+=(--region "$2");  shift 2 ;;
        --prefix)  need_value "$@"; NAME_PREFIX="$2";      shift 2 ;;
        --cluster) need_value "$@"; CLUSTER="$2";          shift 2 ;;
        --jobs)    need_value "$@"; JOBS="$2";             shift 2 ;;
        --lambda-only) LAMBDA_ONLY=1; shift ;;
        --dry-run) DRY_RUN=1; shift ;;
        -h|--help) usage ;;
        *) echo "Unknown option: $1"; usage ;;
    esac
done

# The ECS cluster is named after the install prefix unless --cluster is given.
[[ -z "$CLUSTER" ]] && CLUSTER="$NAME_PREFIX"

if [[ "$ACTION" != "enable" && "$ACTION" != "disable" && "$ACTION" != "status" ]]; then
    echo "Error: action must be 'enable', 'disable', or 'status'"
    usage
fi

if ! [[ "$JOBS" =~ ^[0-9]+$ ]] || (( JOBS < 1 || JOBS > MAX_JOBS )); then
    echo "Error: --jobs must be a whole number from 1 to $MAX_JOBS"
    usage
fi

# Lambda names allow letters, digits, "-" and "_". Anything else is a typo, and
# it must never reach the jq filter.
if ! [[ "$NAME_PREFIX" =~ ^[A-Za-z0-9_-]+$ ]]; then
    echo "Error: --prefix may only contain letters, digits, '-' and '_'"
    usage
fi

# ECS cluster names allow the same characters.
if ! [[ "$CLUSTER" =~ ^[A-Za-z0-9_-]+$ ]]; then
    echo "Error: --cluster may only contain letters, digits, '-' and '_'"
    usage
fi

# -- versions: 5.60.12,5.60.14 -> <prefix>_5_60_12_ , <prefix>_5_60_14_ ----------
# The prefix ends with "_" so that 5.60.1 can never match <prefix>_5_60_12_*.
# Every version is checked here, before any AWS call.

VERSIONS_ARG="${VERSIONS_ARG// /}"
if [[ -z "$VERSIONS_ARG" || "$VERSIONS_ARG" == ,* || "$VERSIONS_ARG" == *, || "$VERSIONS_ARG" == *,,* ]]; then
    echo "Error: empty entry in the version list"
    usage
fi

VERSION_RE='^[0-9]+\.[0-9]+\.[0-9]+(-rc\.[0-9]+)?$'
VERSIONS=()
PREFIXES=()
IFS=',' read -r -a RAW_VERSIONS <<< "$VERSIONS_ARG"
for v in "${RAW_VERSIONS[@]}"; do
    if ! [[ "$v" =~ $VERSION_RE ]]; then
        echo "Error: '$v' is not a full TE version (expected X.Y.Z or X.Y.Z-rc.N, for example 5.60.16 or 5.61.0-rc.10)"
        exit 1
    fi
    dup=0
    for seen in ${VERSIONS[@]+"${VERSIONS[@]}"}; do
        if [[ "$seen" == "$v" ]]; then dup=1; fi
    done
    if [[ $dup -eq 0 ]]; then
        VERSIONS+=("$v")
        # 5.61.0-rc.10 -> 5_61_0_rc_10
        PREFIXES+=("${NAME_PREFIX}_$(echo "$v" | tr '.-' '__')_")
    fi
done
NVER=${#VERSIONS[@]}

# -- scratch space for parallel jobs -------------------------------------------

WORK=$(mktemp -d "${TMPDIR:-/tmp}/turbot_events.XXXXXX")
trap 'rm -rf "$WORK"' EXIT
# Ctrl-C stops new calls. Background jobs ignore SIGINT, so calls already sent
# still finish; there is no summary, so say how to check the result.
trap 'echo; echo "Interrupted. Calls already sent may still complete. Run '"'"'status'"'"' to check."; exit 130' INT TERM

echo "=================================================="
echo " Turbot Events: $(echo "$ACTION" | tr '[:lower:]' '[:upper:]')"
echo "=================================================="
echo " TE version(s)    : $(join_by ', ' "${VERSIONS[@]}")"
echo " Lambda prefix(es): $(join_by ', ' "${PREFIXES[@]}")"
if [[ $LAMBDA_ONLY -eq 1 ]]; then
    echo " Fargate cluster  : (not checked, --lambda-only)"
else
    echo " Fargate cluster  : $CLUSTER"
fi
echo " Action           : $ACTION"
echo " Parallel jobs    : $JOBS"
if [[ "$ACTION" != "status" && $DRY_RUN -eq 1 ]]; then
    echo " Mode             : DRY RUN (no changes will be made)"
fi
echo "=================================================="

if [[ "$ACTION" == "status" && $DRY_RUN -eq 1 ]]; then
    warn "--dry-run has no effect on 'status' (it never changes anything)"
fi

if [[ $LAMBDA_ONLY -eq 1 ]]; then
    warn "--lambda-only: ECS is not checked. Fargate workers (if any) are NOT paused or resumed."
    if [[ "$ACTION" == "enable" ]]; then
        warn "'enable' will turn on every Lambda trigger, including those that a Fargate TE keeps disabled."
    fi
fi

# -- discover matching Lambda functions (one scan for all versions) --------------

header "Discovering Lambda functions..."

PREFIX_JSON=$(printf '%s\n' "${PREFIXES[@]}" | jq -R . | jq -s -c .)

FUNCTIONS_ALL=$(aws lambda list-functions ${CLI[@]+"${CLI[@]}"} --output json \
    | jq -r --argjson ps "$PREFIX_JSON" \
        '.Functions[].FunctionName as $n
         | select(any($ps[]; . as $p | $n | startswith($p)))
         | $n' \
    | sort)

# funcs.tsv: <version index> TAB <function name>, in version order
: > "$WORK/funcs.tsv"
V_FUNCS=(); V_MAPS=(); V_UPD=(); V_SKIP=(); V_ERR=(); V_EN=(); V_DIS=(); V_OTH=()
MISSING=()
FUNC_COUNT=0

for ((i = 0; i < NVER; i++)); do
    # A stable version (5.61.0) must not match its release candidates:
    # turbot_5_61_0_ is a prefix of turbot_5_61_0_rc_9_worker. Skip those.
    names=$(printf '%s\n' "$FUNCTIONS_ALL" | awk -v p="${PREFIXES[$i]}" -v stable="$([[ "${VERSIONS[$i]}" == *-* ]] && echo 0 || echo 1)" \
        'NF && index($0, p) == 1 && !(stable && substr($0, length(p) + 1) ~ /^rc_[0-9]+_/)')
    n=0
    if [[ -n "$names" ]]; then
        n=$(printf '%s\n' "$names" | wc -l | tr -d ' ')
        printf '%s\n' "$names" | awk -v i="$i" '{ print i "\t" $0 }' >> "$WORK/funcs.tsv"
    fi
    V_FUNCS[$i]=$n
    V_MAPS[$i]=0; V_UPD[$i]=0; V_SKIP[$i]=0; V_ERR[$i]=0
    V_EN[$i]=0; V_DIS[$i]=0; V_OTH[$i]=0
    FUNC_COUNT=$((FUNC_COUNT + n))
done

# -- discover Fargate worker services (ECS) ---------------------------------------
# A TE runs its SQS workers on Fargate when the services <prefix>_<version>_worker_*_fg
# exist. (<prefix>_<version>_events_fg is the event intake service. It is never
# touched.) The match needs "worker_" right after the version prefix, so a stable
# version (5.61.0) cannot match an rc service (..._5_61_0_rc_16_worker_...).
# Any ECS read error other than "cluster not found" stops the run before a change:
# a pause that silently skips Fargate would not pause anything.

# per-version Fargate data
V_SVC=(); V_FGQ=(); V_FGQ_UNKNOWN=()
# per-service data (index = line number in svcs.tsv)
S_VIDX=(); S_NAME=(); S_ARN=(); S_STATUS=(); S_DES=(); S_RUN=(); S_PEND=()
S_ASMIN=(); S_ASMAX=(); S_SD=(); S_SMIN=(); S_SMAX=()
SVC_COUNT=0
CLUSTER_FOUND=1
: > "$WORK/svcs.tsv"

# list_services: print the names of all services in the cluster, one per line.
# Exit 0 with no output and a marker file when the cluster does not exist.
list_services() {
    local token="" page tok_arg=()
    while true; do
        tok_arg=()
        [[ -n "$token" ]] && tok_arg=(--next-token "$token")
        if ! page=$(aws ecs list-services ${CLI[@]+"${CLI[@]}"} --cluster "$CLUSTER" \
                ${tok_arg[@]+"${tok_arg[@]}"} --output json 2>&1 </dev/null); then
            if [[ "$page" == *ClusterNotFoundException* ]]; then
                : > "$WORK/no_cluster"
                return 0
            fi
            echo "$page" >&2
            return 1
        fi
        echo "$page" | jq -r '.serviceArns[] | split("/") | last'
        token=$(echo "$page" | jq -r '.nextToken // empty')
        [[ -z "$token" ]] && break
    done
}

if [[ $LAMBDA_ONLY -eq 0 ]]; then
    header "Discovering Fargate worker services (cluster $CLUSTER)..."
    if ! SERVICES_ALL=$(list_services); then
        echo
        echo "Error: could not list the ECS services in cluster '$CLUSTER' (see above). Nothing was changed."
        echo "       Fix the permissions or the --cluster name. Use --lambda-only only on a TE without Fargate workers."
        exit 1
    fi
    if [[ -f "$WORK/no_cluster" ]]; then
        CLUSTER_FOUND=0
        skip "ECS cluster '$CLUSTER' not found: no Fargate workers"
        SERVICES_ALL=""
    fi
else
    SERVICES_ALL=""
fi

for ((i = 0; i < NVER; i++)); do
    snames=$(printf '%s\n' "$SERVICES_ALL" | awk -v p="${PREFIXES[$i]}" \
        'NF && index($0, p) == 1 && $0 ~ /_fg$/ && substr($0, length(p) + 1) ~ /^worker_/')
    n=0
    if [[ -n "$snames" ]]; then
        n=$(printf '%s\n' "$snames" | wc -l | tr -d ' ')
        printf '%s\n' "$snames" | awk -v i="$i" '{ print i "\t" $0 }' >> "$WORK/svcs.tsv"
    fi
    V_SVC[$i]=$n
    V_FGQ[$i]=""; V_FGQ_UNKNOWN[$i]=0
    SVC_COUNT=$((SVC_COUNT + n))
done

# one line per version, then stop before any change if a version matches nothing
# (usually a typo)
echo
MISSING=()
for ((i = 0; i < NVER; i++)); do
    if [[ ${V_SVC[$i]} -gt 0 ]]; then rt="fargate"; else rt="lambda"; fi
    echo "  ${VERSIONS[$i]}  (${PREFIXES[$i]}) : ${V_FUNCS[$i]} Lambda function(s), ${V_SVC[$i]} Fargate worker service(s) -> runtime: $rt"
    if [[ ${V_FUNCS[$i]} -eq 0 && ${V_SVC[$i]} -eq 0 ]]; then
        MISSING+=("${VERSIONS[$i]} (prefix ${PREFIXES[$i]})")
    fi
done

if [[ ${#MISSING[@]} -gt 0 ]]; then
    echo
    echo "Error: no Lambda functions or Fargate worker services found for: $(join_by '; ' "${MISSING[@]}")"
    echo "Nothing was changed."
    exit 1
fi

# -- parallel helpers --------------------------------------------------------------
# Plain bash job pool (no 'wait -n', so it also runs on bash 3.2).
# Jobs cannot update the parent's variables, so each one writes its result to a
# file in $WORK and the parent reads them after 'wait'.

wait_for_slot() {
    while [[ "$(jobs -rp | wc -l | tr -d ' ')" -ge "$JOBS" ]]; do
        sleep 0.2
    done
}

# fetch every event source mapping of one function into $WORK/map.<n>.tsv
# (uuid TAB state TAB queue). Manual --marker pagination keeps this correct on
# both AWS CLI v1 (no auto-pagination) and v2 (auto-paginated; NextMarker
# never appears, so the loop runs once).
fetch_mappings() {
    local n="$1" func="$2" out="$WORK/map.$1" next_marker="" page
    local marker_arg=()
    : > "$out.tmp"
    while true; do
        marker_arg=()
        [[ -n "$next_marker" ]] && marker_arg=(--marker "$next_marker")

        if ! page=$(aws lambda list-event-source-mappings ${CLI[@]+"${CLI[@]}"} \
                --function-name "$func" ${marker_arg[@]+"${marker_arg[@]}"} \
                --output json 2>"$out.err" </dev/null); then
            mv "$out.err" "$out.fail"
            return 0
        fi

        echo "$page" | jq -r '.EventSourceMappings[]
            | [.UUID, .State, (.EventSourceArn | split(":") | last)] | @tsv' >> "$out.tmp"

        next_marker=$(echo "$page" | jq -r '.NextMarker // empty')
        [[ -z "$next_marker" ]] && break
    done
    mv "$out.tmp" "$out.tsv"
}

header "Reading triggers ($FUNC_COUNT function(s), up to $JOBS at a time)..."

n=0
while IFS=$'\t' read -r _ func <&3; do
    wait_for_slot
    fetch_mappings "$n" "$func" &
    n=$((n + 1))
done 3< "$WORK/funcs.tsv"
wait

# stop before any change if a lookup failed
LOOKUP_FAILED=0
n=0
while IFS=$'\t' read -r _ func <&3; do
    if [[ ! -f "$WORK/map.$n.tsv" ]]; then
        warn "could not read triggers for $func: $(tr '\n' ' ' < "$WORK/map.$n.fail" 2>/dev/null || echo 'unknown error')"
        LOOKUP_FAILED=$((LOOKUP_FAILED + 1))
    fi
    n=$((n + 1))
done 3< "$WORK/funcs.tsv"

if [[ $LOOKUP_FAILED -gt 0 ]]; then
    echo
    echo "Error: could not read triggers for $LOOKUP_FAILED function(s). Nothing was changed."
    exit 1
fi

# -- read the Fargate worker services ---------------------------------------------
# Everything a change needs is read here, before anything is written: the desired
# count, the autoscaling bounds, the values that an earlier 'disable' saved in the
# service tags, and the queues the service serves (WORKER_QUEUE_TYPES in its task
# definition, for example "events:3,events_priority:1,events_factory:3").
# The queue list tells 'enable' which Lambda triggers must stay Disabled.

# read_service <name>: sets the R_* variables. Returns 1 on error (text in R_ERR).
read_service() {
    local name="$1" out row
    R_ERR=""
    if ! out=$(aws ecs describe-services ${CLI[@]+"${CLI[@]}"} --cluster "$CLUSTER" \
            --services "$name" --include TAGS --output json 2>&1 </dev/null); then
        R_ERR="describe-services: $out"
        return 1
    fi
    row=$(echo "$out" | jq -r --arg kd "$TAG_DESIRED" --arg kn "$TAG_MIN" --arg kx "$TAG_MAX" '
        if ((.failures | length) > 0) or ((.services | length) == 0) then "FAIL"
        else .services[0] as $s
            | ($s.tags // []) as $t
            | [ $s.serviceArn, $s.status,
                ($s.desiredCount | tostring), ($s.runningCount | tostring), ($s.pendingCount | tostring),
                $s.taskDefinition,
                ([$t[] | select(.key == $kd) | .value][0] // "-"),
                ([$t[] | select(.key == $kn) | .value][0] // "-"),
                ([$t[] | select(.key == $kx) | .value][0] // "-") ]
            | @tsv
        end')
    if [[ "$row" == "FAIL" ]]; then
        R_ERR="service not found in cluster $CLUSTER"
        return 1
    fi
    IFS=$'\t' read -r R_ARN R_STATUS R_DES R_RUN R_PEND R_TD R_SD R_SMIN R_SMAX <<< "$row"

    if ! out=$(aws application-autoscaling describe-scalable-targets ${CLI[@]+"${CLI[@]}"} \
            --service-namespace ecs --scalable-dimension ecs:service:DesiredCount \
            --resource-ids "service/$CLUSTER/$name" --output json 2>&1 </dev/null); then
        R_ERR="describe-scalable-targets: $out"
        return 1
    fi
    R_ASMIN=$(echo "$out" | jq -r '.ScalableTargets[0].MinCapacity // "-"')
    R_ASMAX=$(echo "$out" | jq -r '.ScalableTargets[0].MaxCapacity // "-"')

    if ! out=$(aws ecs describe-task-definition ${CLI[@]+"${CLI[@]}"} \
            --task-definition "$R_TD" --output json 2>&1 </dev/null); then
        R_ERR="describe-task-definition: $out"
        return 1
    fi
    R_QTYPES=$(echo "$out" | jq -r '[.taskDefinition.containerDefinitions[].environment[]?
        | select(.name == "WORKER_QUEUE_TYPES") | .value] | .[0] // empty')
    return 0
}

if [[ $SVC_COUNT -gt 0 ]]; then
    header "Reading Fargate worker services ($SVC_COUNT service(s))..."
    s=0
    SVC_FAILED=0
    while IFS=$'\t' read -r vidx name <&3; do
        if read_service "$name"; then
            S_VIDX[$s]=$vidx; S_NAME[$s]=$name; S_ARN[$s]=$R_ARN; S_STATUS[$s]=$R_STATUS
            S_DES[$s]=$R_DES; S_RUN[$s]=$R_RUN; S_PEND[$s]=$R_PEND
            S_ASMIN[$s]=$R_ASMIN; S_ASMAX[$s]=$R_ASMAX
            S_SD[$s]=$R_SD; S_SMIN[$s]=$R_SMIN; S_SMAX[$s]=$R_SMAX

            if [[ -z "$R_QTYPES" ]]; then
                V_FGQ_UNKNOWN[$vidx]=1
            else
                IFS=',' read -r -a qtypes <<< "$R_QTYPES"
                for qt in ${qtypes[@]+"${qtypes[@]}"}; do
                    V_FGQ[$vidx]="${V_FGQ[$vidx]} ${PREFIXES[$vidx]}${qt%%:*}"
                done
            fi
        else
            warn "could not read $name: $(echo "$R_ERR" | tr '\n' ' ')"
            SVC_FAILED=$((SVC_FAILED + 1))
        fi
        s=$((s + 1))
    done 3< "$WORK/svcs.tsv"

    if [[ $SVC_FAILED -gt 0 ]]; then
        echo
        echo "Error: could not read $SVC_FAILED Fargate worker service(s). Nothing was changed."
        exit 1
    fi
fi

# fargate_queue <version index> <queue name>: 0 when a Fargate worker of that
# version serves the queue (its Lambda trigger must stay Disabled).
fargate_queue() {
    [[ ${V_SVC[$1]} -gt 0 ]] || return 1
    case " ${V_FGQ[$1]} " in
        *" $2 "*) return 0 ;;
        *)        return 1 ;;
    esac
}

# 'enable' must know which Lambda triggers Fargate serves. Without the queue list
# it could turn on a trigger that runs next to the Fargate worker, so stop.
if [[ "$ACTION" == "enable" ]]; then
    for ((i = 0; i < NVER; i++)); do
        if [[ ${V_SVC[$i]} -gt 0 && ${V_FGQ_UNKNOWN[$i]} -eq 1 ]]; then
            echo
            echo "Error: ${VERSIONS[$i]}: a Fargate worker task definition has no WORKER_QUEUE_TYPES,"
            echo "       so the script cannot tell which Lambda triggers must stay disabled. Nothing was changed."
            exit 1
        fi
    done
fi

# per-version table, shown only when more than one version was requested
print_version_table() {
    local i
    echo
    local rt
    if [[ "$ACTION" == "status" ]]; then
        printf "  %-14s  %-8s  %9s  %7s  %8s  %13s  %7s\n" "VERSION" "RUNTIME" "FUNCTIONS" "ENABLED" "DISABLED" "TRANSITIONING" "FARGATE"
        for ((i = 0; i < NVER; i++)); do
            if [[ ${V_SVC[$i]} -gt 0 ]]; then rt="fargate"; else rt="lambda"; fi
            printf "  %-14s  %-8s  %9s  %7s  %8s  %13s  %7s\n" "${VERSIONS[$i]}" "$rt" "${V_FUNCS[$i]}" \
                "${V_EN[$i]}" "${V_DIS[$i]}" "${V_OTH[$i]}" "${V_SVC[$i]}"
        done
    else
        local upd_title="UPDATED"
        [[ $DRY_RUN -eq 1 ]] && upd_title="WOULD UPDATE"
        printf "  %-14s  %-8s  %9s  %8s  %12s  %7s  %6s\n" "VERSION" "RUNTIME" "FUNCTIONS" "MAPPINGS" "$upd_title" "SKIPPED" "ERRORS"
        for ((i = 0; i < NVER; i++)); do
            if [[ ${V_SVC[$i]} -gt 0 ]]; then rt="fargate"; else rt="lambda"; fi
            printf "  %-14s  %-8s  %9s  %8s  %12s  %7s  %6s\n" "${VERSIONS[$i]}" "$rt" "${V_FUNCS[$i]}" \
                "${V_MAPS[$i]}" "${V_UPD[$i]}" "${V_SKIP[$i]}" "${V_ERR[$i]}"
        done
        echo "  (Fargate worker services are counted in the Fargate lines of the summary.)"
    fi
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

    n=0
    while IFS=$'\t' read -r vidx func <&3; do
        mf="$WORK/map.$n.tsv"
        n=$((n + 1))

        if [[ ! -s "$mf" ]]; then
            printf "  %-50s  %-35s  %s\n" "$func" "(no mappings)" "-"
            continue
        fi

        while IFS=$'\t' read -r _ state source <&4; do
            note=""
            if fargate_queue "$vidx" "$source"; then
                if [[ "$state" == "Disabled" ]]; then
                    note="  (served by Fargate, stays Disabled)"
                else
                    note="  ⚠ served by Fargate: both runtimes read this queue"
                fi
            fi
            printf "  %-50s  %-35s  %s%s\n" "$func" "$source" "$(state_label "$state")" "$note"
            V_MAPS[$vidx]=$((V_MAPS[$vidx] + 1))

            case "$state" in
                Enabled)  ALL_ENABLED=$((ALL_ENABLED + 1));   V_EN[$vidx]=$((V_EN[$vidx] + 1))   ;;
                Disabled) ALL_DISABLED=$((ALL_DISABLED + 1)); V_DIS[$vidx]=$((V_DIS[$vidx] + 1)) ;;
                *)        ALL_OTHER=$((ALL_OTHER + 1));       V_OTH[$vidx]=$((V_OTH[$vidx] + 1)) ;;
            esac
        done 4< "$mf"
    done 3< "$WORK/funcs.tsv"

    FG_RUNNING=0
    FG_PAUSED=0
    FG_OTHER=0
    if [[ $SVC_COUNT -gt 0 ]]; then
        header "Current Fargate worker service states (cluster $CLUSTER)"
        printf "\n  %-52s  %7s  %7s  %7s  %11s  %s\n" "SERVICE" "DESIRED" "RUNNING" "PENDING" "AUTOSCALING" "STATE"
        printf "  %-52s  %7s  %7s  %7s  %11s  %s\n" \
            "----------------------------------------------------" "-------" "-------" "-------" "-----------" "-----"
        for ((s = 0; s < ${#S_NAME[@]}; s++)); do
            if [[ "${S_ASMIN[$s]}" == "-" ]]; then bounds="none"; else bounds="${S_ASMIN[$s]}-${S_ASMAX[$s]}"; fi
            if [[ "${S_STATUS[$s]}" != "ACTIVE" ]]; then
                st="${S_STATUS[$s]}"; FG_OTHER=$((FG_OTHER + 1))
            elif [[ ${S_DES[$s]} -eq 0 && "${S_SD[$s]}" != "-" ]]; then
                if [[ ${S_RUN[$s]} -gt 0 ]]; then
                    st="Pausing… (tasks still stopping)"; FG_OTHER=$((FG_OTHER + 1))
                else
                    st="Paused (saved: desired ${S_SD[$s]}, bounds ${S_SMIN[$s]}-${S_SMAX[$s]})"; FG_PAUSED=$((FG_PAUSED + 1))
                fi
            elif [[ ${S_DES[$s]} -eq 0 ]]; then
                st="⚠ at 0, not paused by this script (no saved values)"; FG_OTHER=$((FG_OTHER + 1))
            elif [[ ${S_RUN[$s]} -ne ${S_DES[$s]} || ${S_PEND[$s]} -gt 0 ]]; then
                st="Scaling…"; FG_OTHER=$((FG_OTHER + 1))
            else
                st="Running"; FG_RUNNING=$((FG_RUNNING + 1))
                [[ "${S_SD[$s]}" != "-" ]] && st="Running (⚠ stale saved values from an earlier pause)"
            fi
            printf "  %-52s  %7s  %7s  %7s  %11s  %s\n" "${S_NAME[$s]}" "${S_DES[$s]}" "${S_RUN[$s]}" "${S_PEND[$s]}" "$bounds" "$st"
        done
    fi

    echo
    echo "=================================================="
    echo " Status Summary"
    echo "=================================================="
    echo " TE version(s)    : $(join_by ', ' "${VERSIONS[@]}")"
    echo " Lambda prefix(es): $(join_by ', ' "${PREFIXES[@]}")"
    echo " Functions        : $FUNC_COUNT"
    echo " Enabled          : $ALL_ENABLED"
    echo " Disabled         : $ALL_DISABLED"
    [[ $ALL_OTHER -gt 0 ]] && echo " Transitioning    : $ALL_OTHER ⚠"
    if [[ $LAMBDA_ONLY -eq 0 ]]; then
        echo " Fargate services : $SVC_COUNT (running $FG_RUNNING, paused $FG_PAUSED, other $FG_OTHER)"
    fi
    echo " Time taken       : $(elapsed)"
    [[ $NVER -gt 1 ]] && print_version_table
    echo "=================================================="
    exit 0
fi

# -- enable / disable: plan ---------------------------------------------------------

TOTAL_MAPPINGS=0
UPDATED=0
SKIPPED=0
ERRORS=0

[[ "$ACTION" == "enable" ]] && ENABLED_FLAG="--enabled" || ENABLED_FLAG="--no-enabled"
TARGET_STATE=$([ "$ACTION" = "enable" ] && echo "Enabled" || echo "Disabled")

# one entry per mapping that needs a change
T_VIDX=(); T_FUNC=(); T_UUID=(); T_SRC=(); T_FROM=()

n=0
while IFS=$'\t' read -r vidx func <&3; do
    header "${VERSIONS[$vidx]}  $func"
    mf="$WORK/map.$n.tsv"
    n=$((n + 1))

    if [[ ! -s "$mf" ]]; then
        skip "no event source mappings, skipping"
        continue
    fi

    while IFS=$'\t' read -r uuid state source <&4; do
        TOTAL_MAPPINGS=$((TOTAL_MAPPINGS + 1))
        V_MAPS[$vidx]=$((V_MAPS[$vidx] + 1))

        # A Fargate worker serves this queue. Its Lambda trigger stays Disabled:
        # enabling it would run both runtimes on the same queue.
        if [[ "$ACTION" == "enable" ]] && fargate_queue "$vidx" "$source"; then
            if [[ "$state" == "Disabled" ]]; then
                skip "$source: served by Fargate, trigger stays disabled"
            else
                warn "$source: served by Fargate but the trigger is $state (both runtimes read this queue). Not changed; disable that trigger by hand if this is not intended."
            fi
            SKIPPED=$((SKIPPED + 1)); V_SKIP[$vidx]=$((V_SKIP[$vidx] + 1))
            continue
        fi

        # already in target state
        if [[ "$state" == "$TARGET_STATE" ]]; then
            skip "$source: already $(echo "$state" | tr '[:upper:]' '[:lower:]'), no change needed"
            SKIPPED=$((SKIPPED + 1)); V_SKIP[$vidx]=$((V_SKIP[$vidx] + 1))
            continue
        fi

        # in-flight: skip
        if [[ "$state" == "Enabling" || "$state" == "Disabling" || "$state" == "Updating" ]]; then
            warn "$source: in transient state '$state', skipping (retry later)"
            SKIPPED=$((SKIPPED + 1)); V_SKIP[$vidx]=$((V_SKIP[$vidx] + 1))
            continue
        fi

        if [[ $DRY_RUN -eq 1 ]]; then
            info "$source: $state → $TARGET_STATE (dry run, not applied)"
        else
            info "$source: $state → $TARGET_STATE (queued)"
        fi
        T_VIDX+=("$vidx"); T_FUNC+=("$func"); T_UUID+=("$uuid"); T_SRC+=("$source"); T_FROM+=("$state")
    done 4< "$mf"
done 3< "$WORK/funcs.tsv"

NTASKS=${#T_UUID[@]}

# -- enable / disable: Fargate plan ---------------------------------------------------
# disable: save the desired count and the autoscaling bounds in the service tags,
#          set the bounds to 0-0 (so autoscaling does not start tasks again), then
#          set the desired count to 0.
# enable:  restore the bounds, set the desired count (only when it is 0), then
#          remove the saved values.
# Every step can be run again after a partial failure. Saved values are never
# overwritten, so a second 'disable' cannot replace them with zeros.

FG_UPDATED=0
FG_SKIPPED=0
FG_ERRORS=0
# one entry per service that needs a change (F_S = index into the S_* arrays)
F_S=(); F_TAG=(); F_BMIN=(); F_BMAX=(); F_DES=(); F_UNTAG=(); F_MSG=()

is_int() { [[ "$1" =~ ^[0-9]+$ ]]; }

if [[ $SVC_COUNT -gt 0 ]]; then
    header "Fargate worker services (cluster $CLUSTER)"
    for ((s = 0; s < ${#S_NAME[@]}; s++)); do
        name="${S_NAME[$s]}"; des="${S_DES[$s]}"; sd="${S_SD[$s]}"
        asmin="${S_ASMIN[$s]}"; asmax="${S_ASMAX[$s]}"
        has_target=0; [[ "$asmin" != "-" ]] && has_target=1
        saved=0;      [[ "$sd" != "-" ]] && saved=1
        tag=0; bmin=""; bmax=""; ndes=""; untag=0; msg=""

        if [[ "${S_STATUS[$s]}" != "ACTIVE" ]]; then
            warn "$name: service status is ${S_STATUS[$s]}, skipping"
            FG_SKIPPED=$((FG_SKIPPED + 1)); continue
        fi

        if [[ "$ACTION" == "disable" ]]; then
            if [[ $saved -eq 1 && $des -eq 0 ]]; then
                skip "$name: already paused (saved: desired $sd), no change needed"
                FG_SKIPPED=$((FG_SKIPPED + 1)); continue
            fi
            if [[ $saved -eq 0 ]]; then
                if [[ $des -eq 0 ]]; then
                    warn "$name: desired count is already 0 and there are no saved values (not paused by this script), skipping"
                    FG_SKIPPED=$((FG_SKIPPED + 1)); continue
                fi
                if [[ $has_target -eq 1 && "$asmax" == "0" ]]; then
                    warn "$name: autoscaling max is already 0 and there are no saved values. Refusing to save zeros; fix the service by hand."
                    FG_ERRORS=$((FG_ERRORS + 1)); continue
                fi
                tag=1
                msg="saving desired $des"
                [[ $has_target -eq 1 ]] && msg="$msg and autoscaling $asmin-$asmax"
                msg="$msg in tags; "
            else
                msg="finishing an interrupted pause (saved values kept); "
            fi
            if [[ $has_target -eq 1 && ( "$asmin" != "0" || "$asmax" != "0" ) ]]; then
                bmin=0; bmax=0
                msg="${msg}autoscaling $asmin-$asmax → 0-0; "
            fi
            ndes=0
            msg="${msg}desired $des → 0"
        else
            if [[ $saved -eq 0 ]]; then
                if [[ $des -gt 0 ]]; then
                    skip "$name: already running (desired $des), no change needed"
                    FG_SKIPPED=$((FG_SKIPPED + 1)); continue
                fi
                warn "$name: desired count is 0 and no saved values were found, so it cannot be restored. Set the desired count by hand."
                FG_ERRORS=$((FG_ERRORS + 1)); continue
            fi
            if ! is_int "$sd" || [[ "$sd" -lt 1 ]] || { [[ $has_target -eq 1 ]] && { ! is_int "${S_SMIN[$s]}" || ! is_int "${S_SMAX[$s]}"; }; }; then
                warn "$name: the saved values in the service tags are not valid (desired '$sd', autoscaling '${S_SMIN[$s]}'-'${S_SMAX[$s]}'). Fix the service by hand."
                FG_ERRORS=$((FG_ERRORS + 1)); continue
            fi
            if [[ $has_target -eq 1 && ( "$asmin" != "${S_SMIN[$s]}" || "$asmax" != "${S_SMAX[$s]}" ) ]]; then
                bmin="${S_SMIN[$s]}"; bmax="${S_SMAX[$s]}"
                msg="autoscaling $asmin-$asmax → $bmin-$bmax; "
            fi
            if [[ $des -eq 0 ]]; then
                ndes="$sd"
                msg="${msg}desired 0 → $sd; "
            fi
            untag=1
            msg="${msg}saved values removed from tags"
        fi

        if [[ $DRY_RUN -eq 1 ]]; then
            info "$name: $msg (dry run, not applied)"
        else
            info "$name: $msg (queued)"
        fi
        F_S+=("$s"); F_TAG+=("$tag"); F_BMIN+=("$bmin"); F_BMAX+=("$bmax"); F_DES+=("$ndes"); F_UNTAG+=("$untag"); F_MSG+=("$msg")
    done
fi
NFG=${#F_S[@]}

# -- enable / disable: apply (the only place that writes) -------------------------------

# apply_update <task index>: the single call that changes a trigger.
# Runs as a background job; reports through $WORK/res.<task index>.
apply_update() {
    local t="$1" resp rc applied
    resp=$(aws lambda update-event-source-mapping ${CLI[@]+"${CLI[@]}"} \
        --uuid "${T_UUID[$t]}" $ENABLED_FLAG --output json 2>&1 </dev/null) && rc=0 || rc=$?

    if [[ $rc -ne 0 ]]; then
        printf '%s\n' "  ⚠ FAILED ${T_FUNC[$t]} / ${T_SRC[$t]}: $(echo "$resp" | tr '\n' ' ')"
        { echo "fail" > "$WORK/res.$t"; } 2>/dev/null || true
        return 0
    fi

    # report the state AWS returned (may be transitional e.g. "Disabling")
    applied=$(echo "$resp" | jq -r '.State')
    printf '%s\n' "  ✓ ${T_FUNC[$t]} / ${T_SRC[$t]}: ${T_FROM[$t]} → confirmed $applied"
    { echo "ok" > "$WORK/res.$t"; } 2>/dev/null || true
}

if [[ $DRY_RUN -eq 1 ]]; then
    # dry run: the apply step is never reached
    for ((t = 0; t < NTASKS; t++)); do
        V_UPD[${T_VIDX[$t]}]=$((V_UPD[${T_VIDX[$t]}] + 1))
    done
    UPDATED=$NTASKS
elif [[ $NTASKS -gt 0 ]]; then
    header "Applying $NTASKS update(s), up to $JOBS at a time..."
    echo
    for ((t = 0; t < NTASKS; t++)); do
        wait_for_slot
        apply_update "$t" &
    done
    wait

    for ((t = 0; t < NTASKS; t++)); do
        res="fail"
        [[ -f "$WORK/res.$t" ]] && res=$(cat "$WORK/res.$t")
        if [[ "$res" == "ok" ]]; then
            UPDATED=$((UPDATED + 1)); V_UPD[${T_VIDX[$t]}]=$((V_UPD[${T_VIDX[$t]}] + 1))
        else
            ERRORS=$((ERRORS + 1));   V_ERR[${T_VIDX[$t]}]=$((V_ERR[${T_VIDX[$t]}] + 1))
        fi
    done
fi

# -- enable / disable: Fargate apply (sequential: a few services at most) ----------------

# aws_write <aws args...>: run one change. The output is left in W_OUT.
aws_write() {
    W_OUT=$(aws "$@" ${CLI[@]+"${CLI[@]}"} --output json 2>&1 </dev/null) && return 0
    return $?
}

# tag_value <key>: value of a tag in the last list-tags-for-resource output
tag_value() {
    echo "$W_OUT" | jq -r --arg k "$1" '[.tags[]? | select(.key == $k) | .value][0] // "-"'
}

# apply_fargate <plan index>: the steps always run in this order, and stop at the
# first failure: save values -> set bounds -> set desired count -> remove saved values
apply_fargate() {
    local f="$1" s name arn rid json
    s="${F_S[$f]}"; name="${S_NAME[$s]}"; arn="${S_ARN[$s]}"
    rid="service/$CLUSTER/$name"

    if [[ "${F_TAG[$f]}" == "1" ]]; then
        json="[{\"key\":\"$TAG_DESIRED\",\"value\":\"${S_DES[$s]}\"}"
        if [[ "${S_ASMIN[$s]}" != "-" ]]; then
            json="$json,{\"key\":\"$TAG_MIN\",\"value\":\"${S_ASMIN[$s]}\"},{\"key\":\"$TAG_MAX\",\"value\":\"${S_ASMAX[$s]}\"}"
        fi
        json="$json]"
        if ! aws_write ecs tag-resource --resource-arn "$arn" --tags "$json"; then
            echo "  ⚠ FAILED $name: could not save the values in tags (nothing was scaled): $(echo "$W_OUT" | tr '\n' ' ')"
            return 1
        fi
        # scale down only after the saved values read back correctly
        if ! aws_write ecs list-tags-for-resource --resource-arn "$arn"; then
            echo "  ⚠ FAILED $name: could not read the saved tags back (nothing was scaled): $(echo "$W_OUT" | tr '\n' ' ')"
            return 1
        fi
        if [[ "$(tag_value "$TAG_DESIRED")" != "${S_DES[$s]}" ]] || { [[ "${S_ASMIN[$s]}" != "-" ]] &&
              { [[ "$(tag_value "$TAG_MIN")" != "${S_ASMIN[$s]}" ]] || [[ "$(tag_value "$TAG_MAX")" != "${S_ASMAX[$s]}" ]]; }; }; then
            echo "  ⚠ FAILED $name: the saved tags did not read back correctly (nothing was scaled)"
            return 1
        fi
    fi

    if [[ -n "${F_BMIN[$f]}" ]]; then
        if ! aws_write application-autoscaling register-scalable-target --service-namespace ecs \
                --scalable-dimension ecs:service:DesiredCount --resource-id "$rid" \
                --min-capacity "${F_BMIN[$f]}" --max-capacity "${F_BMAX[$f]}"; then
            echo "  ⚠ FAILED $name: could not set autoscaling bounds: $(echo "$W_OUT" | tr '\n' ' ')"
            return 1
        fi
    fi

    if [[ -n "${F_DES[$f]}" ]]; then
        if ! aws_write ecs update-service --cluster "$CLUSTER" --service "$name" --desired-count "${F_DES[$f]}"; then
            echo "  ⚠ FAILED $name: could not set the desired count: $(echo "$W_OUT" | tr '\n' ' ')"
            return 1
        fi
    fi

    if [[ "${F_UNTAG[$f]}" == "1" ]]; then
        if ! aws_write ecs untag-resource --resource-arn "$arn" --tag-keys "$TAG_DESIRED" "$TAG_MIN" "$TAG_MAX"; then
            echo "  ⚠ FAILED $name: scaled, but could not remove the saved tags (run 'enable' again): $(echo "$W_OUT" | tr '\n' ' ')"
            return 1
        fi
    fi

    echo "  ✓ $name: ${F_MSG[$f]}"
    return 0
}

if [[ $DRY_RUN -eq 1 ]]; then
    FG_UPDATED=$NFG
elif [[ $NFG -gt 0 ]]; then
    header "Applying $NFG Fargate service change(s)..."
    echo
    for ((f = 0; f < NFG; f++)); do
        if apply_fargate "$f"; then
            FG_UPDATED=$((FG_UPDATED + 1))
        else
            FG_ERRORS=$((FG_ERRORS + 1))
        fi
    done
fi

# -- summary -----------------------------------------------------------------------

echo
echo "=================================================="
if [[ $DRY_RUN -eq 1 ]]; then
    echo " Summary (DRY RUN - no changes were made)"
else
    echo " Summary"
fi
echo "=================================================="
echo " TE version(s)     : $(join_by ', ' "${VERSIONS[@]}")"
echo " Lambda prefix(es) : $(join_by ', ' "${PREFIXES[@]}")"
echo " Functions found   : $FUNC_COUNT"
echo " Mappings found    : $TOTAL_MAPPINGS"
if [[ $DRY_RUN -eq 1 ]]; then
    echo " Would update      : $UPDATED"
else
    echo " Updated           : $UPDATED"
fi
echo " Skipped (no-op)   : $SKIPPED"
[[ $ERRORS -gt 0 ]] && echo " Errors            : $ERRORS ⚠"
if [[ $LAMBDA_ONLY -eq 0 ]]; then
    echo " Fargate services  : $SVC_COUNT"
    if [[ $DRY_RUN -eq 1 ]]; then
        echo " Fargate to change : $FG_UPDATED"
    else
        echo " Fargate changed   : $FG_UPDATED"
    fi
    echo " Fargate skipped   : $FG_SKIPPED"
    [[ $FG_ERRORS -gt 0 ]] && echo " Fargate errors    : $FG_ERRORS ⚠"
fi
echo " Action            : $(echo "$ACTION" | tr '[:lower:]' '[:upper:]')"
echo " Time taken        : $(elapsed)"
[[ $NVER -gt 1 ]] && print_version_table
echo "=================================================="

if [[ $DRY_RUN -eq 0 && ( $UPDATED -gt 0 || $FG_UPDATED -gt 0 ) ]]; then
    echo
    echo " Note: trigger and task changes are async. Run 'status' to confirm"
    echo " final state once AWS completes the transition."
    if [[ "$ACTION" == "disable" && $FG_UPDATED -gt 0 ]]; then
        echo " Fargate tasks stop one by one. The pause is complete when 'status' shows"
        echo " RUNNING 0 for every worker service. Messages in flight that do not finish"
        echo " return to the queue when their visibility timeout ends."
        echo " Do not deploy a TE update while paused: it can start the workers again."
    fi
    echo "=================================================="
fi

[[ $((ERRORS + FG_ERRORS)) -gt 0 ]] && exit 2 || exit 0
