#!/bin/bash

source './lib/base.sh'
source './lib/git.sh'

cdProjectDir () {
    local projectDir="$(getProjectDirPath)"

    echoInfo "cd $projectDir"
    switchDir "$projectDir"
    isFailed
}

generateCommitFileReport () {
    local reportPath="$(getReportFilePath)"
    local title="$(getRepositoryAndCommitId)"
    local commitId="$(getRemoteReportBranchCommitId)"
    echoInfo "Generate commit files report $reportPath"
    echoInfo "reportPath $reportPath"
    echoInfo "title $title"
    outputTo "$title" "$reportPath"
    appendTo "-----------------------------" "$reportPath"
    outputCommitFilesTo "$commitId" "$reportPath"
}

getRepositoryAndCommitId () {
    local repoName="$(getRepositoryName)"
    local commitId="$(getRemoteReportBranchCommitId)"
    echo "$repoName : $commitId"
}

publishProduction () {
    local releaseName="$(getRemoteReleaseBranchName)"
    local remoteRelease="$(getRemoteName)/release/$(getRemoteReleaseBranchName)"

    echoInfo "Checkout remote release $remoteRelease"
    checkoutRemoteBranch "$remoteRelease"
    isFailed

    echoInfo "Finish release $releaseName"
    finishRelease "$releaseName"
    isFailed

    echoInfo "Push all branches"
    pushAll
    isFailed
}


