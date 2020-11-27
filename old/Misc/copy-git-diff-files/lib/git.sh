#!/bin/bash

# Configuration

# Functions
getCommitFileList () {
	local commitId=$1

	echo $(git log -m -1 --name-only --first-parent --pretty='' $commitId)
}
