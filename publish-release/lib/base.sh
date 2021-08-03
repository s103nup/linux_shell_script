#!/bin/bash

# Environment configuration
source "./env.sh"

# Functions
copyR () {
    local source=$1
    local target=$2

    cp -R $source $target
    isFailed
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

makeDirs () {
    local dirs=$@

    mkdir -p $dirs
    isFailed
}

removeFiles () {
    local files=$@

    rm -rf $files
    isFailed
}

switchDir () {
    local destination=$1

    cd $destination
    isFailed
}

tarDir () {
    local name=$1
    local target=$2

    tar -czf $name $target
    isFailed
}