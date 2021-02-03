#!/bin/bash

# Check applications CLIs exist
EXPECTED_COMMANDS=( python3 pip3 )

for EXPECTED_COMMAND in "${EXPECTED_COMMANDS[@]}"
do
    if ! command -v ${EXPECTED_COMMAND} &> /dev/null
    then
        echo "Please install ${EXPECTED_COMMAND} in order for this script to work"
        exit
    fi
done

# Check to see if the virtual environment has already been created
VIRTUAL_ENVIRONMENT=$(pwd)'/.venv'
if [[ ! -d "${VIRTUAL_ENVIRONMENT}" ]]; then
    python3 -m venv .venv
fi

# Activate virtual environment
source .venv/bin/activate

pip3 install wheel

# Install application
pip3 install -e .

# Deactivate the virtual environment
deactivate

