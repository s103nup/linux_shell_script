#!/bin/sh

getNginxRoot () {
    echo '/var/www/html'
}

getNginxConfigRoot () {
    echo '/etc/nginx/conf.d'
}

getNginxSslRoot () {
    echo '/etc/ssl'
}

getNginxLogRoot () {
    echo '/var/log/nginx'
}

getNginxDefaultDomain () {
    echo 'default.com.tw'
}

getNginxDefaultConfigPath () {
    echo "$(getScriptRoot)/cfg/$(getNginxDefaultDomain).conf"
}

getNginxDefaultSslCrtPath () {
    echo "$(getScriptRoot)/ssl/$(getNginxDefaultDomain).crt"
}

getNginxDefaultSslKeyPath () {
    echo "$(getScriptRoot)/ssl/$(getNginxDefaultDomain).key"
}

getNginxDefaultUser () {
    echo 'phpci'
}
