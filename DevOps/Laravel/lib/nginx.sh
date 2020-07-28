#!/bin/sh

# Environment configuration
source "./env/nginx.sh"

# Functions

createNginxSiteRoot () {
    local siteRoot=$1

    echoInfo "Create Nginx site root $siteRoot"
    makeDirs $siteRoot
    changeOwnerAndGroupRecursive $(getNginxDefaultUser) $(getNginxDefaultUser) $siteRoot
}

initNginxSiteConfig () {
    local cofigPath=$1
    local domain=$2

    echoInfo "Initialize Nginx site config $cofigPath"

    copy $(getNginxDefaultConfigPath) $cofigPath
    replaceInFile $(getNginxDefaultDomain) $domain $cofigPath
}

initNginxSiteSslCrt () {
    local siteCrtPath=$1

    echoInfo "Initialize Nginx site SSL crt $siteCrtPath"
    copy $(getNginxDefaultSslCrtPath) $siteCrtPath
}

initNginxSiteSslKey () {
    local siteKeyPath=$1

    echoInfo "Initialize Nginx site SSL Key $siteKeyPath"
    copy $(getNginxDefaultSslKeyPath) $siteKeyPath
}

createNginxSiteLogRoot () {
    local $siteLogRoot=$1

    echoInfo "Create Nginx site log root $siteLogRoot"
    makeDirs $siteLogRoot
    changeOwnerAndGroupRecursive $(getNginxDefaultUser) $(getNginxDefaultUser) $siteLogRoot
}