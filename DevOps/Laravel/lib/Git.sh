#!/bin/bash

# Configuration
REMOTE_PREFIX='remotes/origin'

# Functions
rollbackDotGitDir () {
    source=$1
    destination=$2
    echoInfo "Rollback \".git\" directory to $destination"
    move "$1/.git" "$2/.git"
}

cleanCurrentBranch () {
    currentBranch=$(git rev-parse --abbrev-ref HEAD)
    echoInfo "Clean $currentBranch branch"
    git reset --hard \
        && git clean -d -f
    isFailed
}

checkoutBranch () {
    branch=$1
    echoInfo "Checkout $branch branch"
    git checkout $branch
    isFailed
}

backupDotGitdir () {
    source=$1
    destination=$2
    echoInfo "Backup \".git\" directory to $destination"
    move "$1/.git" "$2/.git"
}

deleteBranch () {
    branch=$1
    echoInfo "Delete branches $branch"
    git branch -D $branch
    isFailed
}

deleteSpecificPrefixBranchs () {
    prefix=$1
    targetBranches=$(git branch | grep $prefix/ | cut -d ' ' -f 3)
    if [ ! -z "$targetBranches" ]; then
        deleteBranch $targetBranches
    fi
}

updateLocalGit () {
    echoInfo "Update local git"
    git fetch \
        && git remote prune origin
    isFailed
}

checkoutRemoteSpecificBranch () {
    branch="$REMOTE_PREFIX/$1"
    echoInfo "Checkout remote $branch branch"
    git checkout --track $branch
    isFailed
}

checkoutRemoteSpecificPrefixBranch () {
    prefix="$REMOTE_PREFIX/$1/"
    targetBranches=$(git branch -av | grep $prefix | awk -F'  ' '{print $2}' | cut -d ' ' -f1 | cut -d '/' -f3,4 | head -n1)
    checkoutRemoteSpecificBranch $targetBranches
}

displayCurrentBranchDetail () {
    detail=$(git branch -v | grep '\*' | awk -F'* ' '{print $2}')
    echoInfo "Current branch is $detail"
    isFailed
}

