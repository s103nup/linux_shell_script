#!/bin/bash

siteRoot="<site root>"
betaGitBranch="<beta git branch>"

# Switch to site root
cd "${siteRoot}"

# Update local git branch
git checkout "${betaGitBranch}" \
    && git reset --hard \
    && git pull

# Update composer dependency
composer install

# Update laravel config cache and DB schema
php artisan config:cache \
    && php artisan migrate
