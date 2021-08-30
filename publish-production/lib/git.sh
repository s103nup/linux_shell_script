#!/bin/bash

# Functions
checkoutBranch () {
    local branch=$1
    git checkout $branch
}

checkoutRemoteBranch () {
    local branch="$1"
    git checkout --track "$branch"
}

finishRelease () {
    local branchName="$1"
    git-flow release finish "$branchName"
}

getRemoteReleaseBranchName () {
    local prefix="$(getRemoteName)/release/"
    echo "$(git branch -av | grep $prefix | awk -F'  ' '{print $2}' | cut -d ' ' -f1 | cut -d '/' -f4 | head -n1)"
}

getRemoteReportBranchCommitId () {
    echo "$(git branch -av|grep -v HEAD|grep $(getRemoteName)\/$(getReportBranchName) | awk '{print $2}')"
}

getRepositoryName () {
    echo "$(git remote -v|grep push|awk -F '/' '{print $NF}'|awk -F '.' '{print $1}')"
}

outputCommitFilesTo () {
    local commitId=$1
    local to=$2
    git log -m -1 --name-only --first-parent --pretty="" "$commitId" >> "$to"
}

pushAll () {
    git push --all
}