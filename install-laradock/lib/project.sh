#!/bin/bash

source "./env.sh"
source "./lib/base.sh"
source "./lib/git.sh"

# Functions
config () {
    local laradockDir="$(getLaradockInstallDir)"
    local exampleEnv="$(getLaradockExampleEnv)"
    local laradockEnv="$(getLaradockEnv)"
    local directive="$(getLaradockComposeProjectNameDirective)"
    local defaultProjectName="$(getLaradockDefaultComposeProjectName)"
    local projectName="$(getLaradockProjectName)"
    local replaceScript="s/$directive=$defaultProjectName/$directive=$projectName/g"

    echoInfo "Swithc to $laradockDir"
    switchDir "$laradockDir"

    echoInfo "Copy $laradockEnv from $exampleEnv"
    copyRecursive "$exampleEnv" "$laradockEnv"
    
    echoInfo "Update Laradock project name to $laradockDir"
    replaceInFile "$replaceScript" "$laradockEnv"
}

install () {
    local repo="$(getLaradockRepo)"
    local destination="$(getLaradockInstallDir)"

    addGitSubmoduleTo $repo $destination
}