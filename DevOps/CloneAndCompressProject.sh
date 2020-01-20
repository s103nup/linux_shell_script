#!/bin/bash

PATH=$PATH
export PATH

read -p "Please input Git repository URL: " repoUrl

localRepo=$(basename "${repoUrl}")
projectName=$(echo "$localRepo" | cut -f 1 -d '.')
zipName="${projectName}.tar.gz"

echo "Remove local repository \"${projectName}\""
rm -rf "${projectName}"

echo "Clone Git repository from ${repoUrl} to ${projectName}"
git clone "${repoUrl}" "${projectName}"

echo "Compress ${projectName} as ${zipName}"
tar -cvzf "${zipName}" "${projectName}"

echo "Remove compressed local repository"
rm -rf "${projectName}"