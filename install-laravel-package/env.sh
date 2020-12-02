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

getSourceDir () {
	echo "./source"
}

getDemoEnv () {
	echo "env.txt"
}

getDemoFilesystems () {
	echo "filesystems.txt"
}

getDemoRoute () {
	echo "route.txt"
}

getDemoBladeDir () {
	echo "blade/demo"
}

# Project
getPackageName () {
	echo "superbalist/laravel-google-cloud-storage"
}
getProjectRoot () {
    echo "/var/www"
}

getProjectRoutePath () {
	echo "routes/web.php"
}

getProjectViewPath () {
	echo "resources/views/"
}

getProjectFilesystemsPath () {
	echo "config/filesystems.php"
}

getProjectEnvPath () {
	echo ".env"
}

getFilesystemsSearchTarget () {
	echo 'AWS_ENDPOINT'
}
