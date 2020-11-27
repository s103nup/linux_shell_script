#!/bin/bash

PATH=$PATH
export PATH


composer dump-autoload &&
    php artisan config:cache &&
    php artisan l5-swagger:generate &&
    phpunit --testsuite=Feature