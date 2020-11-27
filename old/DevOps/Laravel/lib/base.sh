#!/bin/bash

# Environment configuration
source "./env/base.sh"

# Functions
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

switchDir () {
    local destination=$1

    cd $siteRoot
    isFailed
}

move () {
    local source=$1
    local destination=$2

    mv $1 $2
    isFailed
}

removeDirs () {
    local dirs=$@

    rm -rf $dirs
    isFailed
}

makeDirs () {
    local dirs=$@

    mkdir -p $dirs
    isFailed
}

# isDirExist() {
#     if [ ! -d "$1" ]; then
#         echoErrorAndExit "Directory $1 does not exists"
#     fi
# }

replaceInFile () {
    local search=$1
    local replace=$2
    local destination=$3

    sed -i "s/$search/$replace/g" $destination
    isFailed
}

changePermissionRecursive () {
    local permission=$1
    local target=$2

    chmod -R $permission $target
    isFailed
}

copy () {
    local source=$1
    local target=$2
    
    cp $source $target
    isFailed
}

changeOwnerAndGroupRecursive () {
    local owner=$1
    local group=$2
    local target=$3

    chown -R $owner:$group $target
    isFailed
}

restartService () {
    local service=$1

    systemctl restart $service
    isFailed
}