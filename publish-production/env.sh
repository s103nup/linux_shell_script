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

getRemoteName () {
    echo 'origin'
}

# options
getProjectDirPath () {
    echo '/d/project/'
}

getReportBranchName () {
    echo 'master'
}

getReportFilePath () {
    echo '/d/report/commit-files.txt'
}
