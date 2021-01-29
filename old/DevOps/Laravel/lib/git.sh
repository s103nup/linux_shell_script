#!/bin/bash

# Configuration
GIT_SSH_REMOTE_URL_PREFIX='<git ssh url>'
REMOTE_PREFIX='remotes/origin'


# Functions
rollbackDotGitDir () {
    local source=$1
    local destination=$2

    move "$1/.git" "$2/.git"
}

cleanCurrentBranch () {
    git reset --hard \
        && git clean -f
    isFailed
}

checkoutBranch () {
    local branch=$1

    git checkout $branch
    isFailed
}

backupDotGitdir () {
    local source=$1
    local destination=$2

    move "$1/.git" "$2/.git"
    isFailed
}

deleteBranch () {
    local branch=$1
    
    git branch -D $branch
    isFailed
}

deleteSpecificPrefixBranchs () {
    local prefix=$1
    local targetBranches=$(git branch | grep $prefix/ | cut -d ' ' -f 3)

    if [ ! -z "$targetBranches" ]; then
        deleteBranch $targetBranches
    fi
    isFailed
}

updateLocalGit () {
    git fetch \
        && git remote prune origin
    isFailed
}

checkoutRemoteSpecificBranch () {
    local branch="$REMOTE_PREFIX/$1"

    git checkout --track $branch
    isFailed
}

checkoutRemoteSpecificPrefixBranch () {
    local prefix="$REMOTE_PREFIX/$1/"
    local targetBranches=$(git branch -av | grep $prefix | awk -F'  ' '{print $2}' | cut -d ' ' -f1 | cut -d '/' -f3,4 | head -n1)

    checkoutRemoteSpecificBranch $targetBranches
}

displayCurrentBranchDetail () {
    local detail=$(git branch -v | grep '\*' | awk -F'* ' '{print $2}')

    echoInfo "Current branch is $detail"
    isFailed
}

cloneRepository () {
    local remoteUrl="$GIT_SSH_REMOTE_URL_PREFIX/$1.git"
    local destination=$2

    git clone $remoteUrl $destination
    isFailed
}

