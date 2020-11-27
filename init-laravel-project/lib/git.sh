#!/bin/bash

# Functions
cloneRepository () {
    local remoteUrl=$1
    local destination=$2

    git clone $remoteUrl $destination
    isFailed
}

