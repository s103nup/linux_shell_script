#!/bin/bash
source "./lib/Base.sh"
source "./lib/Composer.sh"
source "./lib/Git.sh"
source "./lib/Laravel.sh"

source "./lib/Project.sh"

read -p "Please input the git repository name of project: " repoName
read -p "Please input project root parent: " projectRootParent
read -p "Please input project domain: " domain

version="6.*"
projectRoot="$projectRootParent/$domain"

createLaravelProject $projectRoot $version

addGitToLaravelProject $repoName $projectRoot

initLaravelProjectOnWindows $projectRoot $domain