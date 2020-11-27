#!/bin/bash

# Functions
createComposerProject () {
    local packageName=$1
    local packageVersion=$2
    local destination=$3
    
    composer create-project --prefer-dist $packageName $destination "$packageVersion"
    isFailed
}