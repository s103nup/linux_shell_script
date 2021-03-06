#!/bin/bash
#
# Notice:
#   1. Make sure ".git" directory exist in backup directory
#   2. Set git repository url to local path, Ex: file:///var/devops/source.git/

source "./lib/base.sh"
source "./lib/git.sh"
source "./lib/composer.sh"
source "./lib/npm.sh"
source "./lib/laravel.sh"


# Basic configuration
siteName="$(getSiteName)"
siteRoot="$(getWebServerRoot)/$siteName"
tempBranch="master"
releaseBranchPrefix="release"
backupRoot="/home/$(getDeployUser)/devops/$siteName/backup"
removeDirs="$(getRemoveDirs)"

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

# Update composer autoload
updateComposerAutoload

# Update Laravel config cache
updateConfigCache

if [ "$(getUseMigration)" = true ]; then
    # Update Laravel migration
    updateMigration
fi

if [ "$(getUseSeeder)" = true ]; then
    # Update Laravel seeder
    updateSeeder
fi

if [ "$(getUseSwagger)" = true ]; then
    # Update Swagger
    updateSwagger
fi

# Display local branchs
displayCurrentBranchDetail

# Backup ".git" directory
backupDotGitdir $siteRoot $backupRoot

if [ "$(getClearFiles)" = true ]; then
    # Remove unecessary files
    removeDirs $removeDirs
fi
