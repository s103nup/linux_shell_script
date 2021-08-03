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

getPublishPath () {
	echo './publish_gw_sdk'
}

getIgnoreList () {
	echo '.git .gitignore tests/ phpunit.xml vendor/ composer.lock node_modules'
}

getSource () {
	# source path
	echo '/d/project/'
}

getTarName () {
	echo 'package_1.1.0.tar.gz'
}
