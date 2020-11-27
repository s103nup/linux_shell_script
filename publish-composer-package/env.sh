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

getSource () {
	echo '/d/personal/git/GW/SDK/gw_sdk/'
}

getIgnoreList () {
	echo '.git .gitignore tests/ phpunit.xml vendor/ composer.lock'
}

getTarName () {
	echo 'gw_sdk_v1.0.2011250.tar.gz'
}