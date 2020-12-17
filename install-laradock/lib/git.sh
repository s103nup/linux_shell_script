#!/bin/bash

# Functions
addGitSubmoduleTo () {
    local repo=$1
    local destination=$2
    git submodule add $1 $2
    isFailed
}