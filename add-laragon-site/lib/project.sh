#!/bin/bash

source "./lib/base.sh"

# Functions
createLaragonConfig () {
    local source="$(getDefaultConfPath)"
    local siteName="$(getSiteName)"
    local siteConfPath="$(getLaragonConfDir)/$siteName.conf"
    local siteNamePattern="s/default.com.tw/$siteName/g"
    local serverRoot="$(getServerRoot)"
    local serverRootPattern="s/server_root/$serverRoot/g"

    echoInfo "Create configuration $siteConfPath"
    copyTo "$source" "$siteConfPath"

    echoInfo "Update site name to $siteName"
    replaceInFile "$siteNamePattern" "$siteConfPath"

    echoInfo "Update server root to $serverRoot"
    replaceInFile "$serverRootPattern" "$siteConfPath"
}

createLogDir () {
    local logDir="$(getLaragonLogDir)/$(getSiteName)"

    echoInfo "Create site log directoy $logDir"
    makeDirs "$logDir"
}