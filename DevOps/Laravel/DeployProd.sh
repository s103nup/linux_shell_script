#!/bin/bash
#
# Notice:
#   1. Make sure ".git" directory exist in backup directory
#   2. Set git repository url to local path, Ex: file:///var/devops/source.git/

siteName="<site name>"
siteRoot="<site root>"
prodGitBranch="<prod git branch>"
backupRoot="<backup root>"

# Switch to site root
cd "${siteRoot}"

# Rollback ".git" directory
mv "${backupRoot}/.git" .

# Update local git branch
git checkout "${prodGitBranch}" \
    && git reset --hard \
    && git pull

# Update composer dependency
composer install

# Update laravel config cache
php artisan config:cache

# Backup ".git" directory
mv .git "${backupRoot}/"

# Remove unecessary files
rm -rf ./other