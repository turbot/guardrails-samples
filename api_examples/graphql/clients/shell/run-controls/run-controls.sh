#!/bin/bash

DRY_RUN=true

function displayHelp {
    echo "Mandatory arguments"
    echo "  --filter: the control query filter that will return a subset of controls to re-run"
    echo "Optional arguments"
    echo "  --profile: controls the profile to run when using the AWS cli (blank)"
    echo "  --dry-run:  the controls in batcheswhen set to true (false)"
}

# Parse the command line into values required by script
while (( "$#" )); do
    case "$1" in
        -f|--filter)
            if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
                FILTER=$2
                shift 2
            else
                echo "[ERROR] Argument for $1 is missing" >&2
                exit 1
            fi
        ;;
        -p|--profile)
            if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
                PROFILE=$2
                shift 2
            else
                echo "[ERROR] Argument for $1 is missing" >&2
                displayHelp
                exit 1
            fi
        ;;
        -d|--dry-run)
            if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
                if [ ${2,,} = "false" ]
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
        --help)
            displayHelp
            exit 0
        ;;
        -*|--*=) # unsupported flags
            echo "[ERROR] Unsupported flag $1" >&2
            exit 1
        ;;
        *) # unsupported positional arguments
            echo "[ERROR] Error: Unsupported argument $1" >&2
            exit 1
        ;;
    esac
done

if [ -z ${FILTER} ]
then
    echo '[ERROR] Expected argument `--filter`' >&2
    displayHelp
    exit 2
fi

EXPECTED_COMMANDS=( turbot )

for EXPECTED_COMMAND in "${EXPECTED_COMMANDS[@]}"
do
    if ! command -v ${EXPECTED_COMMAND} &> /dev/null
    then
        echo "${EXPECTED_COMMAND} could not be found"
        exit
    fi
done

read -r -d '' CONTROL_QUERY <<- EOM
    {
    controls(filter: "<FILTER>" ) {
        paging {
        next
        }
        items {
        turbot {
            id
        }
        type {
            title
        }
        }
    }
    }
EOM

CONTROL_QUERY=${CONTROL_QUERY/<FILTER>/${FILTER}}

# echo '{ "controls": { "paging": { "next": "eyJzb3J0IjpbeyJ0ZXh0IjoiaWQiLCJvcGVyYXRvciI6Ii0ifV0sIndoZXJlIjpbeyJwaXZvdCI6ImlkIiwib3BlcmF0b3IiOiI8IiwidmFsdWUiOiIyMDg3NDQxODM5MjIwNDQifV0sIm1vZGUiOiJuZXh0In0=" }, "items": [ { "turbot": { "id": "208744791818488" }, "reason": null, "type": { "title": "CMDB" } }, { "turbot": { "id": "208744791689442" }, "reason": null, "type": { "title": "CMDB" } }, { "turbot": { "id": "208744791560396" }, "reason": null, "type": { "title": "CMDB" } }, { "turbot": { "id": "208744791433398" }, "reason": null, "type": { "title": "CMDB" } }, { "turbot": { "id": "208744791300256" }, "reason": null, "type": { "title": "CMDB" } }, { "turbot": { "id": "208744791169162" }, "reason": null, "type": { "title": "CMDB" } }, { "turbot": { "id": "208744791040116" }, "reason": null, "type": { "title": "CMDB" } }, { "turbot": { "id": "208744790915166" }, "reason": null, "type": { "title": "CMDB" } }, { "turbot": { "id": "208744790798408" }, "reason": null, "type": { "title": "CMDB" } }, { "turbot": { "id": "208744790668338" }, "reason": null, "type": { "title": "CMDB" } }, { "turbot": { "id": "208744790533148" }, "reason": null, "type": { "title": "CMDB" } }, { "turbot": { "id": "208744790402054" }, "reason": null, "type": { "title": "CMDB" } }, { "turbot": { "id": "208744790262768" }, "reason": null, "type": { "title": "CMDB" } }, { "turbot": { "id": "208744790128602" }, "reason": null, "type": { "title": "CMDB" } }, { "turbot": { "id": "208744789999556" }, "reason": null, "type": { "title": "CMDB" } }, { "turbot": { "id": "208744789870510" }, "reason": null, "type": { "title": "CMDB" } }, { "turbot": { "id": "208744789755800" }, "reason": null, "type": { "title": "CMDB" } }, { "turbot": { "id": "208744789619586" }, "reason": null, "type": { "title": "CMDB" } }, { "turbot": { "id": "208744216072690" }, "reason": null, "type": { "title": "CMDB" } }, { "turbot": { "id": "208744183922044" }, "reason": null, "type": { "title": "CMDB" } } ] } }' | jq '.'

NEXT_PAGE=$(echo -e ${CONTROL_QUERY} | jq -r '.controls.paging.next')
NUM_ITEMS=$(echo -e ${CONTROL_QUERY} | jq '.controls.items | length')
echo echo ${CONTROL_QUERY} | jq '.controls.items[1]'
echo echo ${CONTROL_QUERY} | jq '.controls.items[1] | { id: .turbot.id, control: .type.title }'
#CONTROLS=$(turbot graphql --format json --query "${CONTROL_QUERY}")

echo $CONTROLS > "$(pwd)/test.json"

# turbot graphql controls --filter "${FILTER}"