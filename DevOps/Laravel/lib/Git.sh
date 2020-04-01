#!/bin/bash

# Configuration
GIT_SSH_REMOTE_URL_PREFIX='git@git.ecpay.local:root'
GIT_HTTP_REMOTE_URL_PREFIX='http://git.ecpay.local/root'
REMOTE_PREFIX='remotes/origin'


# Functions
rollbackDotGitDir () {
    source=$1
    destination=$2

    move "$1/.git" "$2/.git"
}

cleanCurrentBranch () {
    currentBranch=$(git rev-parse --abbrev-ref HEAD)

    git reset --hard \
        && git clean -d -f
    isFailed
}

checkoutBranch () {
    branch=$1

    git checkout $branch
    isFailed
}

backupDotGitdir () {
    source=$1
    destination=$2

    move "$1/.git" "$2/.git"
    isFailed
}

deleteBranch () {
    branch=$1
    
    git branch -D $branch
    isFailed
}

deleteSpecificPrefixBranchs () {
    prefix=$1
    targetBranches=$(git branch | grep $prefix/ | cut -d ' ' -f 3)

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
    branch="$REMOTE_PREFIX/$1"

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

cloneRepository () {
    remoteUrl="$GIT_SSH_REMOTE_URL_PREFIX/$1.git"
    destination=$2

    git clone $remoteUrl $destination
    isFailed
}

