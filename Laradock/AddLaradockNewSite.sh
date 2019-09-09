#!/bin/bash

PATH=$PATH
export PATH

read -p "Please input laradock root path: " laradockRoot
read -p "please input site url: " siteUrl

nginxRoot="${laradockRoot}/nginx"
vhostPath="${nginxRoot}/sites"
sslPath="${nginxRoot}/ssl"
defaultUrl="default-dev.com.tw"
defaultConfigName="${defaultUrl}.conf"
vhostConfigPath="${vhostPath}/${siteUrl}.conf"
defaultKeyPath="${sslPath}/default.key"
defaultCrtPath="${sslPath}/default.crt"
vhostKeyPath="${sslPath}/${siteUrl}.key"
vhostCrtPath="${sslPath}/${siteUrl}.crt"

echo "Create vhost config ${vhostConfigPath}"
cp "./${defaultConfigName}" "${vhostConfigPath}"
# Unix
sed -i "" "s/${defaultUrl}/${siteUrl}/g" "${vhostConfigPath}"
# Linux(beta)
# sed -i "s/${defaultUrl}/${siteUrl}/g" "${vhostConfigPath}"

echo "Create ${vhostKeyPath}"
cp "${defaultKeyPath}" "${vhostKeyPath}"

echo "Create ${vhostCrtPath}"
cp "${defaultCrtPath}" "${vhostCrtPath}"

echo "Please add ${siteUrl} to /etc/hosts"