#!/bin/sh

getScriptRoot () {
    echo '.'
}

getColorGreen () {
    echo '\e[0;32m'
}

getColorReset () {
    echo '\e[0m'
}

getColorRed () {
    echo '\e[0;31m'
}

getWebServerRoot () {
	echo '/var/www'
}

getSiteName () {
	echo 'default.com.tw'
}

getDeployUser () {
	echo 'deployuser'
}

getRemoveDirs () {
	echo ''
}

getUseMigration () {
	echo true
}

getUseSeeder () {
	echo true
}

getUseSwagger () {
	echo false
}

getUsePhpunit () {
	echo true
}

getUseDusk () {
	echo false
}

getClearFiles () {
	echo false
}