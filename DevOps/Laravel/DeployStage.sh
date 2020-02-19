#!/bin/bash
#
# Notice:
#   1. Make sure ".git" directory exist in backup directory
#   2. Set git repository url to local path, Ex: file:///var/devops/source.git/

source "./lib/Base.sh"
source "./lib/Git.sh"
source "./lib/Composer.sh"
source "./lib/Npm.sh"
source "./lib/Laravel.sh"


# Basic configuration
siteName="<site name>"
siteRoot="/var/www/$siteName"
tempBranch="master"
releaseBranchPrefix="release"
backupRoot="/home/<user>/devops/$siteName/backup"
removeDirs="<remove directories>"

# Advance configuration
useComposer=false
useNpm=false
useSwagger=false
useClearFiles=false

# Switch to site root
switchDir $siteRoot

# Rollback ".git" directory
rollbackDotGitDir $backupRoot $siteRoot

# Clean current branch
cleanCurrentBranch

# Checkout temparory branch
checkoutBranch $tempBranch

# Delete local release branches
deleteSpecificPrefixBranchs $releaseBranchPrefix

# Update local git
updateLocalGit

# Checkout release branch
checkoutRemoteSpecificPrefixBranch $releaseBranchPrefix

if [ "$useComposer" = true ]; then
    # Install composer dependency that skips installing packages listed in require-dev
    installDependencyNoDev
fi

# Update Laravel config cache
updateConfigCache

if [ "$useNpm" = true ]; then
    # Install npm dependency
    installDependency

    # Compiler front-end scripts
    compilerProd
fi

if [ "$useSwagger" = true ]; then
    # Update Swagger
    updateSwagger
fi

# Display local branchs
displayCurrentBranchDetail

# Backup ".git" directory
backupDotGitdir $siteRoot $backupRoot

if [ "$useClearFiles" = true ]; then
    # Remove unecessary files
    removeDirs $removeDirs
fi