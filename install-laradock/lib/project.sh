#!/bin/bash

source "./env.sh"
source "./lib/base.sh"
source "./lib/git.sh"

# Functions
config () {
    local laradockRoot="$(getProjectRoot)/$(getLaradockProjectName)"
    local exampleEnv="$laradockRoot/$(getLaradockExampleEnv)"
    local laradockEnv="$laradockRoot/$(getLaradockEnv)"
    local projectName="$(getLaradockProjectName)"

    echoInfo "Copy $laradockEnv from $exampleEnv"
    copyRecursive "$exampleEnv" "$laradockEnv"
    
    echoInfo "Update Laradock project name to $projectName"
    replaceInFile "s/COMPOSE_PROJECT_NAME=laradock/COMPOSE_PROJECT_NAME=$projectName/g" "$laradockEnv"

    setupNginx
}

install () {
    local repo="$(getLaradockRepo)"
    local projectRoot="$(getProjectRoot)"
    local destination="$(getLaradockProjectName)"

    switchDir $projectRoot
    addGitSubmoduleTo $repo $destination
}

setupNginx () {
    local laradockRoot="$(getProjectRoot)/$(getLaradockProjectName)"
    local nginxConfPath="$laradockRoot/$(getLaradockNginxSiteConfPath)"
    local sourcePath="$(getScriptSourcePath)"
    local nginxCertDir="$laradockRoot/$(getLaradockNginxCertDir)"
    local serverName="$(getServerName)"

    echoInfo "Enable Nginx HTTPS"
    replaceInFile "s/# listen/listen/g" "$nginxConfPath"
    replaceInFile "s/# ssl_certificate/ssl_certificate/g" "$nginxConfPath"

    echoInfo "Copy certificate files"
    copyRecursive "$sourcePath/default.*" "$nginxCertDir/"

    echoInfo "Update Nginx server_name to $serverName"
    replaceInFile "s/server_name localhost/server_name $serverName/g" "$nginxConfPath"
}