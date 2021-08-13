#/!bin/bash

source "./lib/project.sh"

generateReport
connectionTest "127.0.0.1"
connectionTest "10.99.2.3"