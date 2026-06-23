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

# Collect the organization ID plus every folder ID beneath it (recursively),
# one per line on stdout. Projects can be nested in folders to any depth, so a
# simple `parent.id=<org>` filter is not enough — we must know every parent
# container in the org's hierarchy. This walks folders only (far fewer than
# projects) and needs no Cloud Asset API.
function collectParentIds {
    local ORG_ID=$1

    echo "${ORG_ID}"

    local QUEUE
    QUEUE=$(gcloud resource-manager folders list --organization=${ORG_ID} \
        --format="value(name)" 2>/dev/null)

    while [[ -n ${QUEUE} ]]
    do
        local NEXT=""
        local FOLDER
        for FOLDER in ${QUEUE}
        do
            echo "${FOLDER}"
            local SUB
            SUB=$(gcloud resource-manager folders list --folder=${FOLDER} \
                --format="value(name)" 2>/dev/null)
            if [[ -n ${SUB} ]]
            then
                NEXT="${NEXT} ${SUB}"
            fi
        done
        QUEUE="${NEXT}"
    done
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

    echo "[INFO] Mapping the folder hierarchy under organization ${ORG_ID}"

    # Build the set of every parent container (org + all nested folders) so we
    # can match projects at any depth, not just direct org children.
    local PARENT_IDS
    PARENT_IDS=$(collectParentIds "${ORG_ID}")
    local PARENT_COUNT
    PARENT_COUNT=$(echo "${PARENT_IDS}" | grep -c .)
    echo "[INFO] Found ${PARENT_COUNT} container(s) (organization + folders)"

    echo "[INFO] Listing projects under organization ${ORG_ID}"

    # List every project the caller can see (with its direct parent id), then
    # keep only those whose parent is the org or one of its folders. One project
    # list call + a local join avoids a slow per-folder query and the Cloud Asset
    # API (which needs a usable quota project).
    local PROJECTS_TSV
    PROJECTS_TSV=$(echo "${PARENT_IDS}" | awk '
        NR==FNR { if ($0 != "") ids[$0]=1; next }
        ($2 in ids) { print $1"\t"$3 }
    ' - <(gcloud projects list --format="value(projectId,parent.id,lifecycleState)" 2>/dev/null))

    if [[ -z ${PROJECTS_TSV} ]]
    then
        echo "[WARN] No projects found under organization ${ORG_ID}." >&2
        echo "[WARN] Check that you have resourcemanager.projects.list permission and" >&2
        echo "[WARN] that the organization ID is correct." >&2
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
