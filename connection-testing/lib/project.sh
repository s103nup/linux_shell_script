#!/bin/bash

source "./lib/base.sh"

# Functions
generateReport () {
    echoInfo "Generate report $(getReportFile)"
    echo "" > "$(getReportFile)"
}

getConnectResult () {
    local status=$1
    local destination=$2
    local result="Connect to $destination"
    if [ $status = true ]; then
        result="$result failed."
    else
        result="$result succeed."
    fi
    echo $result
}

getNmapPortCheckResult () {
    local status=$1
    local destination=$2
    local port=$3
    local result="$destination port $port"
    if [ $status = true ]; then
        result="$result opened."
    else
        result="$result closed."
    fi
    echo $result
}

httpConnectionTest () {
    local destination=$1
    local status=false
    local result=""

    echoInfo "Connecting $destination ..."
    curl -s -o /dev/null -m "$(getMaxtime)" "$destination"
    status="$(isFailed)"
    result="$(getConnectResult $status $destination)"

    # Display and log
    echoInfo "$result"
    appendLogTo "$(getReportFile)" "$result"
}

isPortOpen () {
    local response=$1
    local isOpen=false
    if [ -n "$response" ]; then
        isOpen=true
    fi
    echo $isOpen
}

nmapPortCheck () {
    local destination=$1
    local port=$2
    local response=""
    local status=""
    local result=""

    echoInfo "Checking $destination port $port status ..."
    response="$(nmap -Pn "$destination" -p "$port" --open | grep open)"
    status=$(isPortOpen "$response")
    result="$(getNmapPortCheckResult $status $destination $port)"

    # Display and log
    echoInfo "$result"
    appendLogTo "$(getReportFile)" "$result"
}