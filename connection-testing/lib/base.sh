#!/bin/bash

# Environment configuration
source "./env.sh"

# Functions
appendLogTo () {
    local logFile=$1
    local log=$2
    local now="$(date +"%Y-%m-%d %T")"

    echo "[$now] $log" >> "$logFile"
}

echoInfo () {
    echo -e "Info: $(getColorGreen)$1$(getColorReset)"
}

isFailed () {
    local result=$?

    if [ $result -ne 0 ]; then
        echo true
    else
        echo false
    fi
}