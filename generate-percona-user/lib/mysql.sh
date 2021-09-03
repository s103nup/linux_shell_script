#!/bin/bash

createUser () {
    local user=$1
    local password=$2
    local host=$3

    mysql -u "$(getAdminUser)" \
        -p \
        -e "CREATE USER '$user'@'$host' IDENTIFIED BY '$password';"
}

reloadPrivileges () {
    mysql -u "$(getAdminUser)" \
        -p \
        -e "FLUSH PRIVILEGES"
}

grantPrivileges () {
    local privileges=$1
    local database=$2
    local table=$3
    local user=$4
    local host=$5

    mysql -u "$(getAdminUser)" \
        -p \
        -e "GRANT $privileges ON $database.$table TO '$user'@'$host';"
}