#!/bin/bash

source "./lib/base.sh"
source "./lib/nginx.sh"

# Basic configuration
read -p "Please input domain: " domain
siteRoot="$(getNginxRoot)/$domain/public"
siteNginxCfgPath="$(getNginxConfigRoot)/$domain.conf"
siteNginxLogRoot="$(getNginxLogRoot)/$domain"

# Init configuration
initCertificate=false

# Create site root
createNginxSiteRoot $siteRoot

# Init site configuration
initNginxSiteConfig $siteNginxCfgPath $domain

if [ "$initCertificate" = true ]; then
    # Init site SSL crt and key
	siteCrtPath="$(getNginxSslRoot)/certs/$domain.crt"
	siteKeyPath="$(getNginxSslRoot)/private/$domain.key"
	initNginxSiteSslCrt $siteCrtPath
	initNginxSiteSslKey $siteKeyPath
fi

# Create site log directory
createNginxSiteLogRoot $siteNginxLogRoot

# Restart Nginx service
