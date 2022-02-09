#!/bin/bash
#
# Notice:
#   1. Make sure ".git" directory exist in backup directory
#   2. Set git repository url to local path, Ex: file:///var/devops/source.git/

source "./lib/base.sh"
source "./lib/git.sh"
source "./lib/composer.sh"
source "./lib/laravel.sh"

# Basic configuration
siteName="$(getSiteName)"
siteRoot="$(getWebServerRoot)/$siteName"
tempBranch="master"
featureBranchPrefix="feature"
removeDirs="$(getRemoveDirs)"

# Switch to site root
switchDir $siteRoot

# Clean current branch
cleanCurrentBranch

# Checkout temparory branch
checkoutBranch $tempBranch

# Delete local feature branches
deleteSpecificPrefixBranchs $featureBranchPrefix

# Update local git
updateLocalGit

# Checkout feature branch
checkoutRemoteSpecificPrefixBranch $featureBranchPrefix

# Update composer autoload
updateComposerAutoload

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

if [ "$(getUsePhpunit)" = true ]; then
    # Feature test
    runPhpunit
fi

if [ "$(getUseDusk)" = true ]; then
    # E2e test
    runDusk
fi

# Display local branchs
displayCurrentBranchDetail

if [ "$(getClearFiles)" = true ]; then
    # Remove unecessary files
    removeDirs $removeDirs
fi
