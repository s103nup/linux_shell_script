#!/bin/bash

source "./lib/base.sh"
source "./lib/nginx.sh"

# Basic configuration
read -p "Please input domain: " domain
siteNginxCfgPath="$(getNginxConfigRoot)/$domain.conf"
siteCrtPath="$(getNginxSslRoot)/certs/$domain.crt"
siteKeyPath="$(getNginxSslRoot)/private/$domain.key"
siteNginxLogRoot="$(getNginxLogRoot)/$domain"

# Create site root
createNginxSiteRoot $siteRoot

# Init site configuration
initNginxSiteConfig $siteNginxCfgPath $domain

# Init site SSL crt and key
initNginxSiteSslCrt $siteCrtPath
initNginxSiteSslKey $siteKeyPath

# Create site log directory
createNginxSiteLogRoot $siteNginxLogRoot