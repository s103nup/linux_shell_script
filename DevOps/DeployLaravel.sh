#!/bin/bash

# Global configuraion
deployRoot="<deploy root>"
deployBranch="<deploy branch>"

echo "Change to deploy root"
cd "${deployRoot}"

echo "Pull from git repository"
git checkout "${deployBranch}"
git pull

echo "Update laravel config cache"
php artisan config:cache