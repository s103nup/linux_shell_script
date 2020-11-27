#!/bin/bash

source "./lib/base.sh"
source "./lib/composer.sh"
source "./lib/git.sh"

# Functions
installLaravel () {
    local destination=$1
    local version=$2
    local packageName="laravel/laravel"

    echoInfo "Install Laravel $version to $destination"

    createComposerProject $packageName $version $destination
}

addGitToLaravel () {
    local gitRemote=$1
    local projectRoot=$2
    local tempDir="./temp"

    echoInfo "Add repository $gitRemote to $projectRoot"

    cloneRepository $gitRemote $tempDir
    migrateGit $tempDir $projectRoot
}

migrateGit () {
    local tempDir=$1
    local destination="$2/"
    local dotGitDir="$tempDir/.git"

    echoInfo "Migrate $dotGitDir to $destination"

    move $dotGitDir $destination
    removeDirs $tempDir
}

initLaravel () {
    local projectRoot=$1
    local domain=$2
    local sourceRoot="./source"

    echoInfo "Initialize Laravel"

    read -p "Please input domain: " domain
    updateLaravelAppUrl $projectRoot $domain
    makeLaravelCustomizeDirs $projectRoot
    if [ $("isLinux") == "Y" ]; then
        echoInfo "changeLaravelStoragePermission"
    fi
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

makeLaravelCustomizeDirs () {
    local projectRoot=$1
    echoInfo "Make Laravel customize directories"

    # app
    local laravelRoot="$projectRoot/app"
    local modelDir="$laravelRoot/Models"
    local repositoryDir="$laravelRoot/Repositories"
    local serviceDir="$laravelRoot/Services"

    local customizeDirs=($modelDir $repositoryDir $serviceDir)

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
