#!/bin/bash

# Environment configuration
source './env.sh'

# Functions
echoErrorAndExit () {
    echo -e "Error: $(getColorRed)$1$(getColorReset)"
    exit 1
}

echoInfo () {
    echo -e "Info: $(getColorGreen)$1$(getColorReset)"
}

isFailed () {
    local result=$?
    if [ "$result" -ne 0 ]; then
        echo false
    else
        echo true
    fi
}

exitWhenFailed () {
    local result="$(isFailed)"
    local defaultMsg="Failed!"

    if [ $result = false ]; then
        echoErrorAndExit $defaultMsg
    fi
}