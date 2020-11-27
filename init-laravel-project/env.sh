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

getLaravelDefaultVersion () {
    echo "6.*"
}

getGitRemoteUrl () {
    echo ''
}

getGitRemotePrefix () {
    echo 'remotes/origin'
}