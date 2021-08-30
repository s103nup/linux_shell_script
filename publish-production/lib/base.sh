#!/bin/bash

# Environment configuration
source "./env.sh"

# Functions
appendTo () {
    local input=$1
    local to=$2

    echo "$input" >> "$to"
}

echoErrorAndExit () {
    echo -e "Error: $(getColorRed)$1$(getColorReset)"
    exit 1
}

echoInfo () {
    echo -e "Info: $(getColorGreen)$1$(getColorReset)"
}

isFailed () {
    # Execution result
    local result=$?

    # Set error message
    local defaultMsg="Failed!"
    if [ $# -gt 0 ]; then
        defaultMsg=$1
    fi

    # Check execution result
    if [ $result -ne 0 ]; then
        echoErrorAndExit $defaultMsg
    fi
}

outputTo () {
    local input=$1
    local to=$2

    echo "$input" > "$to"
}

switchDir () {
    local destination=$1

    cd $destination
    isFailed
}
