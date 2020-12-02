#!/bin/bash

source "./env.sh"
source "./lib/base.sh"
source "./lib/composer.sh"

# Functions
addDemoRoute () {
    local destination=$1
    local source=$("getSourceDir")/$("getDemoRoute")

    echoInfo "Add demo route to $destination"
    appendToFile $source $destination
}

config () {
    local projectRoot=$("getProjectRoot")
    local filesystemsPath=$projectRoot/$("getProjectFilesystemsPath")
    local envPath=$projectRoot/$("getProjectEnvPath")

    updateFilesystems $filesystemsPath
    updateEnv $envPath
}

copyDemoBlade () {
    local destination=$1
    local source=$("getSourceDir")/$("getDemoBladeDir")/

    echoInfo "Create demo blade in $destination"
    copyDir $source $destination
}

generateDemoCode () {
    local projectRoot=$("getProjectRoot")
    local viewPath=$projectRoot/$("getProjectViewPath")
    local routePath=$projectRoot/$("getProjectRoutePath")

    copyDemoBlade $viewPath
    addDemoRoute $routePath
}

install () {
    local package=$("getPackageName")
    local current=$(pwd)
echo $current

    echoInfo "Install $package package"
    switchDir $("getProjectRoot")
    composerInstall $package
    switchDir $current
echo $(pwd)
}

updateEnv () {
    local destination=$1
    local source=$("getSourceDir")/$("getDemoEnv")

echo $(pwd)
    echoInfo "Add package .env variables to $destination"
    appendToFile $source $destination
}

updateFilesystems () {
    local destination=$1
    local source=$("getSourceDir")/$("getDemoFilesystems")
    local searchTarget=$("getFilesystemsSearchTarget")

    echoInfo "Add package filesystems configuration to $destination"
    insertToFile "/$searchTarget/r $source" $destination
}
