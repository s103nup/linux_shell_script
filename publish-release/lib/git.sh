#!/bin/bash

# Functions
checkoutBranch () {
    local branch=$1
    git checkout $branch
}

deleteBranch () {
    local branch=$1
    git branch -D $branch
}

generateReleaseBranch () {
    local releaseName=$1
    git-flow release start "$releaseName"
}

getRemoteReleaseCommitId () {
    echo "$(git branch -av|grep $(getRemoteName)\/release | awk '{print $2}')"
}

getRepositoryName () {
    echo "$(git remote -v|grep push|awk -F '/' '{print $NF}'|awk -F '.' '{print $1}')"
}

outputCommitFilesTo () {
    local commitId=$1
    local to=$2
    git log -m -1 --name-only --first-parent --pretty="" "$commitId" >> "$to"
}

pushToRemote () {
    local fullBranch=$1
    git push --set-upstream "$(getRemoteName)" "$fullBranch"
}

updateLocalGit () {
    git pull \
        && git remote prune "$(getRemoteName)"
}