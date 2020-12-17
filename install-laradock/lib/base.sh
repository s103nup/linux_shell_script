#!/bin/bash

# Environment configuration
source "./env.sh"

# Functions
copyRecursive () {
    local source=$1
    local destination=$2

    cp -rf $source $destination
    isFailed
}

echoErrorAndExit () {
    local content=$1
    
    echoMessageByType "Error" "$content" $(getColorRed)
    exit 1
}

echoInfo () {
    local content=$1

    echoMessageByType "Info" "$content" $(getColorGreen)
}

echoMessageByType () {
    local type=$1
    local content=$2
    local color=$3
    echo -e "$type: $color$content$(getColorReset)"
}

echoNotice () {
    local content=$1
    
    echoMessageByType "Notice" "$content" $(getColorYellow)
}

replaceInFile () {
    local script=$1
    local inputFile=$2

    sed -i "$script" $inputFile
    isFailed
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

switchDir () {
    local destination=$1

    cd $destination
    isFailed
}
