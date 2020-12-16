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

# Project
getLaradockEnv () {
	echo ".env"
}

getLaradockExampleEnv () {
	echo "env-example"
}

getLaradockInstallDir () {
	echo "./laradock-demo"
}

getLaradockProjectName () {
	echo "laradock-demo"
}

getLaradockRepo () {
	echo "https://github.com/Laradock/laradock.git"
}

getLaradockComposeProjectNameDirective () {
	echo "COMPOSE_PROJECT_NAME"
}

getLaradockDefaultComposeProjectName () {
	echo "laradock"
}