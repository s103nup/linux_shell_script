#!/bin/bash

# Functions

# Clone from repository

createLaravelProject () {
    destination=$1
    version=$2
    packageName="laravel/laravel"

    # Set version
    defaultVersion="6.*"
    if [ -z $version ]; then
        version=$defaultVersion
    fi

    echoInfo "Create project on $destination using Laravel $version"

    createComposerProject $packageName $version $destination
}

addGitToLaravelProject () {
    repoName=$1
    projectRoot=$2
    tempDir="./temp"

    echoInfo "Add Git to Laravel project $projectRoot"

    cloneRepository $repoName $tempDir
    migrateGitRepository $tempDir $projectRoot
}

migrateGitRepository () {
    tempDir=$1
    destination="$2/"
    dotGitDir="$tempDir/.git"

    echoInfo "Migrate $dotGitDir to $destination"

    move $dotGitDir $destination
    removeDirs $tempDir
}

initLaravelProjectOnWindows () {
    projectRoot=$1
    domain=$2
    sourceRoot="./source"

    echoInfo "Initialize Laravel project"

    updateLaravelAppUrl $projectRoot $domain
    migrateReadme $sourceRoot $projectRoot
    makeLaravelCustomizeDirs $projectRoot
}

updateLaravelAppUrl () {
    projectRoot=$1
    domain=$2
    search="http:\/\/localhost"
    replace="https:\/\/$domain"
    envPath="$projectRoot/.env"

    echoInfo "Update APP_URL to $domain"

    replaceInFile $search $replace $envPath
}

migrateReadme () {
    sourceRoot=$1
    projectRoot=$2
    readmePath="$1/git/README.md"

    echoInfo "Migrate $readmePath to $projectRoot"

    copy $readmePath $projectRoot
}

makeLaravelCustomizeDirs () {
    projectRoot=$1
    echoInfo "Make Laravel customize directories"

    # app
    laravelRoot="$projectRoot/app"
    modelDir="$laravelRoot/Models"
    repositoryDir="$laravelRoot/Repositories"
    serviceDir="$laravelRoot/Services"

    # script
    scriptRoot="$projectRoot/scripts"
    devopsScriptRoot="$scriptRoot/devops"
    betaDeployScriptDir="$devopsScriptRoot/beta"
    stageDeployScriptDir="$devopsScriptRoot/stage"
    prodDeployScriptDir="$devopsScriptRoot/prod"

    customizeDirs=($modelDir $repositoryDir $serviceDir $betaDeployScriptDir $stageDeployScriptDir $prodDeployScriptDir)

    for dir in "${customizeDirs[@]}"
    do
        echoInfo "Make $dir directory"
        makeDirs $dir
    done
}

changeLaravelStoragePermission () {
    permission="777"
    projectRoot=$1
    storageDir="$projectRoot/storage"
    echoInfo "Change Laravel storage directory permission to $permission"
    changePermissionRecursive $permission $storageDir
}