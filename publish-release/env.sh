#!/bin/sh
getColorGreen () {
    echo '\e[0;32m'
}

getColorReset () {
    echo '\e[0m'
}

getColorRed () {
    echo '\e[0;31m'
}

getReleaseName () {
	local subVersion="$(date +"%y%m%d")0"
	echo "v1.0.$subVersion"
}

getReleaseSourceBranch () {
    echo 'develop'
}

getRemoteName () {
    echo 'origin'
}
# options
getSource () {
    echo '/d/project/'
}

getReportFilePath () {
    echo '/d/report/commit-files.txt'
}
