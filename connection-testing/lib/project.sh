#!/bin/bash

source "./lib/base.sh"

# Functions
connectionTest () {
    local destination=$1
    local result=""

    echoInfo "Test connecting to $destination"
    curl -s -m "$(getMaxtime)" -o /dev/null "$destination"
    result="$(getConnectResult)"

    # Display and log
    echoInfo "$result"
    appendLogTo "$(getReportFile)" "$result"
}

generateReport () {
    echoInfo "Generate report $(getReportFile)"
    echo "" > "$(getReportFile)"
}

getConnectResult () {
    if [ "$(isFailed)" = true ]; then
        echo "Connect to $destination failed."
    else
        echo "Connect to $destination succeeded."
    fi
}