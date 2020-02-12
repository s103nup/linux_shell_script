#!/bin/bash
siteRoot="<site root>"
mainBranch="master"
useComposer=true
useNpm=true
useSwagger=true
usePhpunit=true
useDusk=true

# Functions
isFailed () {
    # Execution result
    result=$?

    # Set error message
    defaultMsg="Failed!"
    if [ $# -gt 0 ]; then
        defaultMsg=$1
    fi

    # Check execution result
    if [ $result -ne 0 ]; then
        echo $defaultMsg
        exit 1
    fi
}

# Switch to site root
echo "Switch to $siteRoot directory"
if [ ! -d "$siteRoot" ]; then
    echo "Directory $siteRoot does not exists"
    exit
fi
cd "${siteRoot}" \

# Clean current branch
currentBranch=$(git rev-parse --abbrev-ref HEAD)
echo "Clean $currentBranch branch"
git reset --hard \
    && git clean -d -f
isFailed

# Checkout main branch
echo "Checkout $mainBranch branch"
git checkout "$mainBranch"
isFailed

# Delete local feature branches
featureBranches=$(git branch | grep feature/ | cut -d ' ' -f 3)
if [ ! -z "$featureBranches" ]; then
    echo "Delete branches $featureBranches"
    git branch -D "$featureBranches"
    isFailed
fi

# Update local git
echo "Update local git"
git fetch \
    && git remote prune origin
isFailed

# Checkout beta branch
betaBranch=$(git branch -av | grep remotes/origin/feature/ | awk -F'  ' '{print $2}' | cut -d ' ' -f1 | head -n1)
echo "Checkout ${betaBranch} branch"
git checkout --track "${betaBranch}"
isFailed

if [ "$useComposer" = true ]; then
    # Update composer dependency
    echo "Update composer dependency"
    composer install
    isFailed
fi

# Update Laravel config cache
echo "Update Laravel config cache"
php artisan config:cache
isFailed

# Update Laravel migration
echo "Update Laravel migration"
php artisan migrate
isFailed

if [ "$useNpm" = true ]; then
    # Update npm dependency
    echo "Update npm dependency"
    npm install
    isFailed

    # Compiler front-end scripts
    echo "Compiler front-end scripts"
    npm run dev
    isFailed
fi

if [ "$useSwagger" = true ]; then
    # Update Swagger
    echo "Update Swagger"
    php artisan l5-swagger:generate
    isFailed
fi

if [ "$usePhpunit" = true ]; then
    # Feature test
    echo "Run the feature tests"
    ./vendor/bin/phpunit --testdox
    isFailed
fi

if [ "$useDusk" = true ]; then
    # E2e test
    echo "Run the E2E tests"
    php artisan dusk --testdox
    isFailed
fi

# Display local branchs
git branch -v
isFailed