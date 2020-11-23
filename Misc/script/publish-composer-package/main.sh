#!/bin/bash

source "./lib/base.sh"


source="$(getSource)"
publishPath="$(getPublishPath)"
ignoreList="$(getIgnoreList)"
tarName="$(getTarName)"

echoInfo "Clean files"
removeFiles $publishPath $tarName

echoInfo "Clone $source to $publishPath"
copyR $source $publishPath

echoInfo "Remove files: $ignoreList in $publishPath"
switchDir $publishPath
removeFiles $ignoreList

echoInfo "Archive $publishPath to $tarName"
switchDir '..'
tarDir $tarName $publishPath

echoInfo "Remove $publishPath"
removeFiles $publishPath