#!/bin/bash

source './lib/base.sh'
source './lib/mysql.sh'

createPerconaUser () {
    local user="$(getPerconaUser)"
    local password="$(getPerconaUserPassword)"
    local host="$(getMasterIp)"

    echoInfo "Create Percona user $user"
    createUser "$user" "$password" "$host"
    exitWhenFailed
}

grantPerconaUserPrivileges () {
    local user="$(getPerconaUser)"
    local host="$(getMasterIp)"
    local database="$(getPerconaAccessedDb)"

    echoInfo "Grant Percona privileges"
    grantPrivileges 'REPLICATION SLAVE, PROCESS, SELECT, DELETE, INSERT' "$database" '*' "$user" "$host"
    exitWhenFailed

    echoInfo "Reload privileges"
    reloadPrivileges
    exitWhenFailed
}