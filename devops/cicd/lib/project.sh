#!/bin/bash

# Environment configuration
source "./env.beta.sh"

# Functions
backupDotGitDir () {
    if [ "$(getBackupGitDir)" != "" ]
    then
        echoInfo "Backup $(getDotGitDeployPath) to $(getDotGitBackupPath)"

        mv "$(getDotGitDeployPath)" "$(getDotGitBackupPath)"
        [ $? -ne 0 ] && exit
    fi
}

changeToSiteRoot () {
    local siteRoot="$(getSiteRoot)"

    echoInfo "Change directory to $siteRoot"

    cd $siteRoot
    [ $? -ne 0 ] && errorHandler
}

checkoutTemporaryBranch () {
    local tempBranch=$(getTempBranch)

    echoInfo "Checkout $tempBranch branch temporary"

    git checkout $tempBranch
    [ $? -ne 0 ] && errorHandler
}

cleanCurrentBranch () {
    local currentBranch=$(git rev-parse --abbrev-ref HEAD)

    echoInfo "Reset and clean $currentBranch branch"

    git reset --hard && git clean -f
    [ $? -ne 0 ] && errorHandler
}

cleanLaravelCache () {
    if [ "$(getUseLaravelCache)" == true ]
    then
        echoInfo "Remove Laravel cached bootstrap files"

        local cachePath="$(getSiteRoot)/bootstrap/cache/*"
        rm -rf $cachePath
        [ $? -ne 0 ] && errorHandler
    fi
}

createLaravelCache () {
    if [ "$(getUseLaravelCache)" == true ]
    then
        echoInfo "Create Laravel configuration cache"

        php artisan config:cache
        [ $? -ne 0 ] && errorHandler
    fi
}

createNewDeployBranch () {
    local deployBranch=$(getDeployBranch)

    echoInfo "Create $deployBranch branch and set up the upstream"

    local upstream="$(getGitRemoteName)/$deployBranch"
    git checkout --track $upstream
    if [ $? -ne 0 ]
    then
        errorHandler
    else
        echoInfo "Branch: $(git branch -v | grep $deployBranch | awk -F'* ' '{print $2}')"
    fi
}

deleteDeployedBranch () {
    local deployedBranch=$(getDeployedBranch)

    if [ "$deployedBranch" != "" ]
    then
        echoInfo "Delete $deployedBranch branch"

        git branch -D -q $deployedBranch
        [ $? -ne 0 ] && errorHandler
    fi
}

displayCurrentBranchDetail () {
    local detail=$(git branch -v | grep '\*' | awk -F'* ' '{print $2}')

    echoInfo "Current branch: $detail"
}

dumpAutoload () {
    echoInfo "Dump Composer autoload"

    local regex="Package manifest generated successfully.";
    local message="$(composer dump -o 2>&1)"
    [[ ! "$message" =~ $regex ]] && errorHandler "$message"
}

echoDebug () {
    echo -e "Debug: $(getColorYellow)$1$(getColorReset)"
}

echoError () {
    echo -e "Error: $(getColorRed)$1$(getColorReset)"
}

echoInfo () {
    echo -e "Info: $(getColorGreen)$1$(getColorReset)"
}

errorHandler () {
    backupDotGitDir

    local message="Operation Failed!"
    if [ $# -gt 0 ]; then
        message=$1
    fi
    echoError "$message"
    
    exit 1
}

removeUnecessaryFiles () {
    local files="$(getRemovedDirs)"

    if [ "$files" != "" ]
    then
        echoInfo "Remove files $files"
        rm -rf $files
        [ $? -ne 0 ] && exit
    fi
}

rollbackDotGitDir () {
    if [ "$(getBackupGitDir)" != "" ]
    then
        echoInfo "Rollback $(getDotGitBackupPath) to $(getDotGitDeployPath)"

        mv "$(getDotGitBackupPath)" "$(getDotGitDeployPath)"
        [ $? -ne 0 ] && exit
    fi
}

runLaravelMigration () {
    if [ "$(getUseMigration)" == true ]
    then
        echoInfo "Running Laravel migration"

        php artisan migrate --force
        [ $? -ne 0 ] && errorHandler
    fi
}

runPhpunit () {
    if [ "$(getUsePhpunit)" == true ]
    then
        echoInfo "Running PHPUnit"

        php artisan test
        [ $? -ne 0 ] && errorHandler
    fi
}

updateFromRepository () {
    echoInfo "Update from repository"

    git fetch -p
    [ $? -ne 0 ] && errorHandler
}

updateLocalBranch () {
    cleanCurrentBranch

    checkoutTemporaryBranch

    updateFromRepository

    if [ "$(getDeployBranch)" == "" ]
    then
        errorHandler "Deploy branch $(getDeployBranchType) is missing!"
    else
        deleteDeployedBranch

        createNewDeployBranch
    fi
}