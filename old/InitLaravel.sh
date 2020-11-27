#!/bin/bash

PATH=$PATH
export PATH

projectRoot="./"
laravelVersion="5.7.*"

composer create-project --prefer-dist laravel/laravel "${projectRoot}" "${laravelVersion}" \
    && composer require barryvdh/laravel-debugbar:3.2.4 --dev
