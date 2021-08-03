#!/bin/sh

getScriptRoot () {
    echo '.'
}

getColorGreen () {
    echo '\e[0;32m'
}

getColorReset () {
    echo '\e[0m'
}

getColorRed () {
    echo '\e[0;31m'
}

getSource () {
    echo '/d/personal/git/GW/Service/form-api-dev.ecpay.com.tw/'
}

# getReleaseName () {
# 	local subVersion="$(date +"%y%m%d")0"
# 	echo "v1.0.$subVersion"
# }
