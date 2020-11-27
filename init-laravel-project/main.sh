#!/bin/bash
source "./lib/project.sh"

defaultParentPath="."
read -p "Please input project parent path[$defaultParentPath]: " parentPath
parentPath=${parentPath:-$defaultParentPath}
read -p "Please input project name: " name
projectRoot="$parentPath/$name"

defaultVersion="$(getLaravelDefaultVersion)"
read -p "Please input Laravel version[$defaultVersion]:" version
version=${version:-$defaultVersion}

installLaravel $projectRoot $version

read -p "Add Git repository[N]: " repoName
repoName=${repoName:-"N"}
if [ "$repoName" != "N" ]; then
    addGitToLaravel $repoName $projectRoot
fi

initLaravel $projectRoot $name