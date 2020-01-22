#!/bin/bash

siteRoot="<site root>"
betaGitBranch="<beta git branch>"

# Switch to site root
if [ ! -d "${siteRoot}" ]; then
    echo "Directory ${siteRoot} does not exists"
    exit
fi
cd "${siteRoot}" \

# Update local git branch
git checkout "${betaGitBranch}" \
    && git reset --hard \
    && git clean -d -f \
    && git pull
if [ $? -ne 0 ]; then
    echo "Update local git failed"
fi

# Update composer dependency
#composer install

# Update laravel config cache and DB schema
php artisan config:cache \
    && php artisan migrate
if [ $? -ne 0 ]; then
    echo "Update Laravel config cache or migrate failed"
fi