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

    cd $destination
    isFailed
}

makeDirs () {
    local dirs=$@

    mkdir -p $dirs
    isFailed
}

copy () {
    local source=$1
    local target=$2
    
    cp $source $target
    isFailed
}

getFileDir() {
    local path=$1
    echo $(dirname "$path")
}

copyFileAndCreateParent() {
    local file=$1
    local fileParent=$(getFileDir $file)
    local targetDir=$copyedRoot/$fileParent
    local targetFile=$copyedRoot/$file

    echoInfo "Create parent $targetDir"
    makeDirs $targetDir

    echoInfo "Copy $file to $targetFile"
    copy $file $targetFile
}

batchCopyFileAndCreateParent() {
    local fileList=$@
    
    echoInfo "Batch copy file and create parent"
    for file in ${fileList[@]}
    do
        copyFileAndCreateParent $file
    done
}