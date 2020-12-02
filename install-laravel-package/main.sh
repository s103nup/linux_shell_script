#!/bin/bash
source "./lib/project.sh"

install
config
generateDemoCode

echoNotice "Please update .env what you need!"
