#!/bin/bash
source "./lib/base.sh"
source "./lib/composer.sh"
source "./lib/git.sh"
source "./lib/laravel.sh"

source "./lib/project.sh"

read -p "Please input the git repository name of project: " repoName
read -p "Please input project root parent: " projectRootParent
read -p "Please input project domain: " domain

version="6.*"
projectRoot="$projectRootParent/$domain"

createLaravelProject $projectRoot $version

addGitToLaravelProject $repoName $projectRoot

initLaravelProjectOnWindows $projectRoot $domain