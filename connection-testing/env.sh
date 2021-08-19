#!/bin/sh

# Common
getColorGreen () {
    echo '\e[0;32m'
}

getColorReset () {
    echo '\e[0m'
}

# Project
getMaxtime () {
	echo '3'
}

getReportFile () {
	echo './report/connection-testing-report.txt'
}
