#!/bin/bash

# Functions
installComposerDependencyNoDev () {
    composer install --no-dev
    isFailed
}

installComposerDependency () {
    composer install
    isFailed
}


createComposerProject () {
    packageName=$1
    packageVersion=$2
    destination=$3
    
    composer create-project --prefer-dist $packageName $destination "$packageVersion"
    isFailed
}