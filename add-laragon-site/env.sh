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
getDefaultConfPath () {
	echo "D:/linux_shell_script/Laragon/source/default.conf"
}

getLaragonConfDir () {
	echo "C:/laragon/etc/nginx/sites-enabled"
}
getServerRoot () {
	# 特殊符號需跳脫
	echo "D:\/project\/"
}

getSiteName () {
	echo "dev.cf-site.com.tw"
}

getLaragonLogDir () {
	echo "C:/laragon/logs"
}
