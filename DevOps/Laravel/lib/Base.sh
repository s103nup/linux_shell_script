#!/bin/bash

# Configuration
COLOR_REST='\e[0m'
COLOR_GREEN='\e[0;32m'
COLOR_RED='\e[0;31m'

# Functions
echoErrorAndExit () {
    echo -e "Error: $COLOR_RED$1$COLOR_REST"
    exit 1
}

echoInfo () {
    echo -e "Info: $COLOR_GREEN$1$COLOR_REST"
}

isFailed () {
    # Execution result
    result=$?

    # Set error message
    defaultMsg="Failed!"
    if [ $# -gt 0 ]; then
        defaultMsg=$1
    fi

    # Check execution result
    if [ $result -ne 0 ]; then
        echoErrorAndExit $defaultMsg
    fi
}

switchDir () {
    destination=$1
    echoInfo "Switch to $destination directory"
    cd $siteRoot
    isFailed
}

move () {
    source=$1
    destination=$2
    mv $1 $2
    isFailed
}

removeDirs () {
    dirs=$@
    echoInfo "Remove directory $dirs"
}

# isDirExist() {
#     if [ ! -d "$1" ]; then
#         echoErrorAndExit "Directory $1 does not exists"
#     fi
# }