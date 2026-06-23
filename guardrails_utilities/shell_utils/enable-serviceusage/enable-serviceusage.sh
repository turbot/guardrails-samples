#!/bin/bash
#
# Enable the Service Usage API (serviceusage.googleapis.com) across every project
# in a GCP organization.
#
# Dry-run by default: lists the projects and prints what it would do. Pass
# `--dry-run false` to actually enable the API in each project.

function displayHelp {
    echo "Enables serviceusage.googleapis.com across all projects in a GCP organization."
    echo ""
    echo "Mandatory arguments"
    echo "  --org-id: the numeric GCP organization ID whose projects will be processed"
    echo "Optional arguments"
    echo "  --service: the service to enable (serviceusage.googleapis.com)"
    echo "  --dry-run: when 'true' only lists projects, when 'false' enables the service (true)"
    echo "  --skip-system: skip projects whose lifecycle state is not ACTIVE (true)"
    echo "  --help: lists all the options and their usages"
    echo ""
    echo "Remarks"
    echo "  Requires an authenticated gcloud session ('gcloud auth login') with permission"
    echo "  to list projects under the organization and to enable services on each project"
    echo "  (roles/serviceusage.serviceUsageAdmin or equivalent)."
}

function main {
    local SERVICE="serviceusage.googleapis.com"
    local DRY_RUN=true
    local SKIP_NON_ACTIVE=true
    local ORG_ID=""

    START=$(date +%s)

    # Parse the command line into values required by script
    while (( "$#" )); do
        case "$1" in
            -o|--org-id)
                if [[ -n "$2" ]] && [[ ${2:0:1} != "-" ]]
                then
                    ORG_ID=$2
                    shift 2
                else
                    echo "[ERROR] Argument for $1 is missing" >&2
                    displayHelp
                    exit 1
                fi
            ;;
            -s|--service)
                if [[ -n "$2" ]] && [[ ${2:0:1} != "-" ]]
                then
                    SERVICE=$2
                    shift 2
                else
                    echo "[ERROR] Argument for $1 is missing" >&2
                    displayHelp
                    exit 1
                fi
            ;;
            -d|--dry-run)
                if [[ -n "$2" ]] && [[ ${2:0:1} != "-" ]]
                then
                    if [[ ${2} = "false" ]]
                    then
                        DRY_RUN=false
                    fi
                    shift 2
                else
                    echo "[ERROR] Argument for $1 is missing" >&2
                    displayHelp
                    exit 1
                fi
            ;;
            --skip-system)
                if [[ -n "$2" ]] && [[ ${2:0:1} != "-" ]]
                then
                    if [[ ${2} = "false" ]]
                    then
                        SKIP_NON_ACTIVE=false
                    fi
                    shift 2
                else
                    echo "[ERROR] Argument for $1 is missing" >&2
                    displayHelp
                    exit 1
                fi
            ;;
            --help)
                displayHelp
                exit 0
            ;;
            -*|--*=) # unsupported flags
                echo "[ERROR] Unsupported flag $1" >&2
                displayHelp
                exit 1
            ;;
            *) # unsupported positional arguments
                echo "[ERROR] Error: Unsupported argument $1" >&2
                displayHelp
                exit 1
            ;;
        esac
    done

    if [[ -z ${ORG_ID} ]]
    then
        echo '[ERROR] Expected argument `--org-id`' >&2
        displayHelp
        exit 2
    fi

    EXPECTED_COMMANDS=( gcloud jq )

    for EXPECTED_COMMAND in "${EXPECTED_COMMANDS[@]}"
    do
        if ! command -v ${EXPECTED_COMMAND} &> /dev/null
        then
            echo "[ERROR] Please install ${EXPECTED_COMMAND} in order for this script to work" >&2
            exit 1
        fi
    done

    # Confirm there is an active, non-expired gcloud credential before we start.
    if ! gcloud auth list --filter=status:ACTIVE --format="value(account)" 2>/dev/null | grep -q .
    then
        echo "[ERROR] No active gcloud account. Run 'gcloud auth login' first." >&2
        exit 3
    fi

    echo "[INFO] Listing projects under organization ${ORG_ID}"

    # Resolve every project in the organization. gcloud paginates automatically
    # when --format streams; we capture id and lifecycle state as TSV.
    local PROJECTS_TSV
    PROJECTS_TSV=$(gcloud projects list \
        --filter="parent.id=${ORG_ID} AND parent.type=organization" \
        --format="value(projectId,lifecycleState)" 2>/dev/null)

    if [[ -z ${PROJECTS_TSV} ]]
    then
        echo "[WARN] No projects found directly under organization ${ORG_ID}." >&2
        echo "[WARN] Projects nested in folders are not returned by a parent.id filter." >&2
        echo "[WARN] Consider 'gcloud asset search-all-resources' for a full org-wide list." >&2
        exit 0
    fi

    local TOTAL=0
    local SUCCEEDED=0
    local FAILED=0
    local SKIPPED=0

    while IFS=$'\t' read -r PROJECT_ID LIFECYCLE
    do
        [[ -z ${PROJECT_ID} ]] && continue
        let "TOTAL += 1"

        if [[ ${SKIP_NON_ACTIVE} == true ]] && [[ ${LIFECYCLE} != "ACTIVE" ]]
        then
            echo "[INFO] Skipping ${PROJECT_ID} (lifecycle: ${LIFECYCLE})"
            let "SKIPPED += 1"
            continue
        fi

        if [[ ${DRY_RUN} == true ]]
        then
            echo "[DRY-RUN] Would enable ${SERVICE} on ${PROJECT_ID}"
            continue
        fi

        echo "[INFO] Enabling ${SERVICE} on ${PROJECT_ID}"
        if gcloud services enable "${SERVICE}" --project="${PROJECT_ID}" 2>/tmp/enable_err_$$
        then
            echo "[INFO]    Enabled on ${PROJECT_ID}"
            let "SUCCEEDED += 1"
        else
            echo "[ERROR]   Failed on ${PROJECT_ID}: $(cat /tmp/enable_err_$$)" >&2
            let "FAILED += 1"
        fi
        rm -f /tmp/enable_err_$$
    done <<< "${PROJECTS_TSV}"

    echo ""
    echo "[INFO] Total projects processed: ${TOTAL}"
    echo "[INFO]    Skipped (non-active):  ${SKIPPED}"
    if [[ ${DRY_RUN} == false ]]
    then
        echo "[INFO]    Enabled:               ${SUCCEEDED}"
        echo "[INFO]    Failed:                ${FAILED}"
    else
        echo "[INFO] Dry-run mode: no services were enabled. Re-run with '--dry-run false' to apply."
    fi

    END=$(date +%s)
    RUNTIME=$((END - START))
    echo "[INFO] Total time taken ${RUNTIME} second(s)"

    if [[ ${FAILED} -gt 0 ]]
    then
        exit 4
    fi
}

main "$@"
