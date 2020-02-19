#!/bin/bash

# Functions
installDependency () {
    echoInfo "Install npm dependency"
    npm install
    isFailed
}

compilerProd () {
    echoInfo "Compiler production front-end scripts"
    npm run prod
    isFailed
}
compilerDev () {
    echoInfo "Compiler dev front-end scripts"
    npm run dev
    isFailed
}
