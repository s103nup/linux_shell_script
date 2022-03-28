#!/bin/sh

getColorGreen () {
    echo '\e[0;32m'
}

getColorReset () {
    echo '\e[0m'
}

getColorRed () {
    echo '\e[0;31m'
}

getColorYellow () {
    echo '\e[0;33m'
}

getDeployBranch () {
    local branch="$(getDeployBranchType)"
    if [ "$branch" != "master" ]; then
        local refName="refs/remotes/$(getGitRemoteName)/$(getDeployBranchType)/"
        branch="$(git for-each-ref --sort=-committerdate --count=1 --format='%(refname)' "$refName" | cut -d '/' -f 4,5)"
    fi
    echo "$branch"
}

getDeployedBranch () {
    local branch="$(getDeployBranchType)"
    if [ "$branch" != "master" ]; then
        local refName="refs/heads/$(getDeployBranchType)/"
        branch="$(git for-each-ref --sort=-committerdate --count=1 --format='%(refname)' "$refName" | cut -d '/' -f 3,4)"
    fi
    echo "$branch"
}

getDotGitBackupPath () {
    echo "$(getBackupGitDir)/.git"
}

getDotGitDeployPath () {
    echo "$(getSiteRoot)/.git"
}

getSiteRoot () {
    echo "$(getWebServerRoot)/$(getSiteName)"
}

# Customize
getBackupGitDir () {
    echo "~/backup"
}

getDeployBranchType () {
    echo "master"
}

getGitRemoteName () {
    echo "origin"
}

getRemovedDirs () {
    echo ""
}

getSiteName () {
    echo "example.com"
}

getTempBranch () {
    echo "develop"
}

getUseLaravelCache () {
    echo true
}

getUseMigration () {
    echo true
}

getUsePhpunit () {
    echo false
}

getWebServerRoot () {
    echo "/var/www/html"
}