#!/bin/sh

# Common
getColorGreen () {
    echo '\e[0;32m'
}

getColorReset () {
    echo '\e[0m'
}

getColorRed () {
    echo '\e[0;31m'
}

getColorYellow () {
	echo '\e[33m'
}

# Project Common
getLaradockEnv () {
	echo ".env"
}

getLaradockExampleEnv () {
	echo "env-example"
}

getLaradockRepo () {
	echo "https://github.com/Laradock/laradock.git"
}

getLaradockNginxCertDir () {
	echo "nginx/ssl"
}

getLaradockNginxSiteConfPath () {
	echo "nginx/sites/default.conf"
}

# Project customize
getLaradockProjectName () {
	echo "laradock-cf-demo"
}

getProjectRoot () {
	echo "~/project/cf-demo"
}

getScriptSourcePath () {
	echo "~/script/linux_shell_script/install-laradock/source"
}

getServerName () {
	echo "cf-demo.com.tw"
}