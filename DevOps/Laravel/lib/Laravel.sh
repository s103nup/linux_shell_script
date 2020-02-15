#!/bin/bash

# Functions
updateConfigCache () {
    echoInfo "Update Laravel config cache"
    php artisan config:cache
    isFailed
}

updateSwagger () {
    echoInfo "Update Swagger"
    php artisan l5-swagger:generate
    isFailed
}