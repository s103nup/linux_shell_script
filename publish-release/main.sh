#!/bin/bash


subVersion="$(date +"%y%m%d")0"
releaseName="v1.0.$subVersion"

commitId=$(git flow release start $releaseName && git push --set-upstream origin release/$releaseName && git branch -av|grep "origin\/release" | awk '{print $2}')
repoName=$(git remote -v|grep push|awk -F '/' '{print $NF}'|awk -F '.' '{print $1}')
echo "$repoName : $commitId"