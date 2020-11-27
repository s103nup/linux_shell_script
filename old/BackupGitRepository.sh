#!/bin/bash

PATH="/usr/bin/":"/mingw64/bin/"
export PATH

read -p "Please input the repository directory that you want to backup: " dir

current=$(pwd)

echo "Change to ${dir}"
cd "${dir}"

echo "Pull the develop branch"
git checkout develop && git pull

echo "Pull the master branch"
git checkout master && git pull

echo "Back to ${current}"
cd "${current}"

echo "Archive the directory \"${dir}\" as \"${dir}.tar.gz\""
tar -cvzf "${dir}.tar.gz" "${dir}"

echo "Remove the directory ${dir}"
rm -rf "${dir}"

echo "Finished"
