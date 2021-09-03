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

# options
getAdminUser () {
    echo 'root'
}

getPerconaUser () {
    echo 'percona'
}

getPerconaUserPassword () {
    echo 'test1234'
}

getMasterIp () {
    echo '10.20.1.66'
}

getPerconaAccessedDb () {
    echo '*'
}