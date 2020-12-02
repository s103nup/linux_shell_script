#!/bin/bash

# Functions
composerInstall () {
    local packageName=$1

	composer require $packageName
    isFailed
}
