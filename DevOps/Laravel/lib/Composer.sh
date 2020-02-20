#!/bin/bash

# Functions
installDependencyNoDev () {
    echoInfo "Install composer dependency that skips installing packages listed in require-dev"
    composer install --no-dev
    isFailed
}

installDependency () {
    echoInfo "Install composer dependency"
    composer install
    isFailed
}