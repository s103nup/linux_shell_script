#!/bin/bash
#
# Notice:
#   1. Make sure ".git" directory exist in backup directory
#   2. Set git repository url to local path, Ex: file:///var/devops/source.git/

siteName="<site name>"
siteRoot="<site root>"
prodGitBranch="<prodction git branch>"
backupRoot="<backup root>"

# Switch to site root
if [ ! -d "${siteRoot}" ]; then
    echo "Directory ${siteRoot} does not exists"
    exit
fi
cd "${siteRoot}" \

# Rollback ".git" directory
if [ ! -d "${backupRoot}" ]; then
    echo "Directory ${backupRoot} does not exists"
    exit
fi
mv "${backupRoot}/.git" .

# Update local git branch
git checkout "${prodGitBranch}" \
    && git reset --hard \
    && git clean -d -f \
    && git pull
if [ $? -ne 0 ]; then
    echo "Update local git failed"
fi

# Update composer dependency
#composer install

# Update laravel config cache
php artisan config:cache
if [ $? -ne 0 ]; then
    echo "Update Laravel config cache failed"
fi

# Backup ".git" directory
mv .git "${backupRoot}/"

# Remove unecessary files
#rm -rf ./other