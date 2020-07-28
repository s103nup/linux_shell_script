#!/bin/bash

# Functions

# Clone from repository

createLaravelProject () {
    local destination=$1
    local version=$2
    local packageName="laravel/laravel"

    # Set version
    local defaultVersion="6.*"
    if [ -z $version ]; then
        version=$defaultVersion
    fi

    echoInfo "Create project on $destination using Laravel $version"

    createComposerProject $packageName $version $destination
}

addGitToLaravelProject () {
    local repoName=$1
    local projectRoot=$2
    local tempDir="./temp"

    echoInfo "Add Git to Laravel project $projectRoot"

    cloneRepository $repoName $tempDir
    migrateGitRepository $tempDir $projectRoot
}

migrateGitRepository () {
    local tempDir=$1
    local destination="$2/"
    local dotGitDir="$tempDir/.git"

    echoInfo "Migrate $dotGitDir to $destination"

    move $dotGitDir $destination
    removeDirs $tempDir
}

initLaravelProjectOnWindows () {
    local projectRoot=$1
    local domain=$2
    local sourceRoot="./source"

    echoInfo "Initialize Laravel project"

    updateLaravelAppUrl $projectRoot $domain
    migrateReadme $sourceRoot $projectRoot
    makeLaravelCustomizeDirs $projectRoot
}

updateLaravelAppUrl () {
    local projectRoot=$1
    local domain=$2
    local search="http:\/\/localhost"
    local replace="https:\/\/$domain"
    local envPath="$projectRoot/.env"

    echoInfo "Update APP_URL to $domain"

    replaceInFile $search $replace $envPath
}

migrateReadme () {
    local sourceRoot=$1
    local projectRoot=$2
    local readmePath="$1/git/README.md"

    echoInfo "Migrate $readmePath to $projectRoot"

    copy $readmePath $projectRoot
}

makeLaravelCustomizeDirs () {
    local projectRoot=$1
    echoInfo "Make Laravel customize directories"

    # app
    local laravelRoot="$projectRoot/app"
    local modelDir="$laravelRoot/Models"
    local repositoryDir="$laravelRoot/Repositories"
    local serviceDir="$laravelRoot/Services"

    # script
    local scriptRoot="$projectRoot/scripts"
    local devopsScriptRoot="$scriptRoot/devops"
    local betaDeployScriptDir="$devopsScriptRoot/beta"
    local stageDeployScriptDir="$devopsScriptRoot/stage"
    local prodDeployScriptDir="$devopsScriptRoot/prod"

    local customizeDirs=($modelDir $repositoryDir $serviceDir $betaDeployScriptDir $stageDeployScriptDir $prodDeployScriptDir)

    for dir in "${customizeDirs[@]}"
    do
        echoInfo "Make $dir directory"
        makeDirs $dir
    done
}

changeLaravelStoragePermission () {
    local permission="777"
    local projectRoot=$1
    local storageDir="$projectRoot/storage"
    
    echoInfo "Change Laravel storage directory permission to $permission"
    changePermissionRecursive $permission $storageDir
}
