#!/bin/bash

# Global configuraion
projectName="<project>"

# Remote configuration
remoteUser="<remote user>"
remoteHost="<remote host>"
remoteRoot="/home/${remoteUser}/ci_source"
remoteZipName="${projectName}.tar.gz"

# Local configuration
localUser="<local user>"
localRoot="/home/${localUser}"
localZipName="${projectName}.tar.gz"
localZipPath="${localRoot}/${localZipName}"

echo "Remove the previous version files"
rm -rf "${localRoot}/${projectName}.git/"

echo "Change to local root"
cd "${localRoot}"

echo "Copy the file from remote"
scp "${remoteUser}@${remoteHost}:${remoteRoot}/${remoteZipName}" "${localZipPath}"

echo "Decompress the source file"
tar -xvzf "${localZipPath}"

echo "Remove the source file"
rm -f "${localZipPath}"