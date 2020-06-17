#!/bin/bash

source "./lib/base.sh"
source "./lib/git.sh"


copyedRoot=$(pwd)/copyed
read -p "Please input the git project path: " projectPath

echoInfo "Switch to $projectPath directory"
switchDir $projectPath

read -p "Please input the commit id: " commitId
commitId="c50174f"
echoInfo "Get commit file list"
fileList=$(getCommitFileList $commitId)

batchCopyFileAndCreateParent $fileList