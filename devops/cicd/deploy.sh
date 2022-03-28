#!/bin/bash
#
# Notice:
#   1. Make sure ".git" directory exist in backup directory
#   2. Set git repository url to local path, Ex: file:///var/devops/source.git/

source "./lib/project.sh"

changeToSiteRoot

rollbackDotGitDir

cleanLaravelCache

updateLocalBranch

dumpAutoload

createLaravelCache

runLaravelMigration

runPhpunit

displayCurrentBranchDetail

backupDotGitDir

removeUnecessaryFiles