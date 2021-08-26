#!/bin/bash

source './lib/base.sh'
source './lib/git.sh'

cdProjectDir () {
    local projectDir="$(getSource)"
    echoInfo "cd $projectDir"
    switchDir "$projectDir"
}

generateCommitFileReport () {
    local reportPath="$(getReportFilePath)"
    local title="$(getRepositoryAndCommitId)"
    local commitId="$(getRemoteReleaseCommitId)"
    echoInfo "Generate commit files report $reportPath"
    outputTo "$title" "$reportPath"
    appendTo "-----------------------------" "$reportPath"
    outputCommitFilesTo "$commitId" "$reportPath"
}

getRepositoryAndCommitId () {
    local repoName="$(getRepositoryName)"
    local commitId="$(getRemoteReleaseCommitId)"
    echo "$repoName : $commitId"
}

publishRelease () {
    local releaseSourceBranch="$(getReleaseSourceBranch)"
    local releaseName="$(getReleaseName)"
    local fullReleaseName="release/$releaseName"

    echoInfo "Checkout $releaseSourceBranch"
    checkoutBranch "$releaseSourceBranch"
    isFailed

    echoInfo "Update git branchs"
    updateLocalGit
    isFailed

    echoInfo "Init release branch $releaseName from $releaseSourceBranch"
    generateReleaseBranch $releaseName
    isFailed

    echoInfo "Push $releaseName to remote"
    pushToRemote $fullReleaseName
    isFailed

    echoInfo "Checkout $releaseSourceBranch"
    checkoutBranch "$releaseSourceBranch"
    isFailed

    echoInfo "Delete $fullReleaseName"
    deleteBranch $fullReleaseName
}


