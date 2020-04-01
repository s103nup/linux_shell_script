#!/bin/bash

# Functions
installNpmDependency () {
    npm install
    isFailed
}

compilerProd () {
    npm run prod
    isFailed
}
compilerDev () {
    npm run dev
    isFailed
}
