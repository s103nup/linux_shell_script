#!/bin/sh
#
# Functions

createSiteRoot () {
    local siteRoot=$1
    local siteRoot=$1
    local siteRoot=$1
    echoInfo "Create site root directory $siteRoot"
    makeDirs $siteRoot
    changeOwnerAndGroupRecursive $nginxUser $nginxUser $siteRoot
}

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
# 
# Create site root
echoInfo "Create site root directory $siteRoot"