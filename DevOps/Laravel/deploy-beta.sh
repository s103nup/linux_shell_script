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
siteName="<site name>"
siteRoot="/var/www/$siteName"
tempBranch="master"
featureBranchPrefix="feature"
backupRoot="/home/<user>/devops/$siteName/backup"
removeDirs="<remove direcoties>"

# Advance configuration
useComposer=false
useMigration=false
useNpm=false
useSwagger=false
usePhpunit=false
useDusk=false
useClearFiles=false

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

if [ "$useComposer" = true ]; then
    # Install composer dependency
    installComposerDependency
fi

# Update Laravel config cache
updateConfigCache

if [ "$useMigration" = true ]; then
    # Update Laravel migration
    updateMigration
fi

if [ "$useNpm" = true ]; then
    # Install npm dependency
    installNpmDependency

    # Compiler front-end scripts
    compilerProd
fi

if [ "$useSwagger" = true ]; then
    # Update Swagger
    updateSwagger
fi

if [ "$usePhpunit" = true ]; then
    # Feature test
    runPhpunit
fi

if [ "$useDusk" = true ]; then
    # E2e test
    runDusk
fi

# Display local branchs
displayCurrentBranchDetail

if [ "$useClearFiles" = true ]; then
    # Remove unecessary files
    removeDirs $removeDirs
fi