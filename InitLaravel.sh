#!/bin/bash

PATH="/usr/bin/":"/mingw64/bin/":"/c/ProgramData/ComposerSetup/bin/":"/c/laragon/bin/php/php-7.2.11-Win32-VC15-x64/"
export PATH

projectRoot="./"
laravelVersion="5.7.*"

composer create-project --prefer-dist laravel/laravel "${projectRoot}" "${laravelVersion}" \
    && composer require barryvdh/laravel-debugbar:3.2.4 --dev
