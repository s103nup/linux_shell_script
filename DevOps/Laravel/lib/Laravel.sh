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

updateMigration () {
    echoInfo "Update Laravel migration"
    php artisan migrate
    isFailed
}

runPhpunit () {
    echoInfo "Run the Phpunit tests"
    ./vendor/bin/phpunit --testdox
    isFailed
}

runDusk () {
    echoInfo "Run the Dusk tests"
    php artisan dusk --testdox
    isFailed
}