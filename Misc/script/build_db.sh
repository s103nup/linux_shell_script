#!/bin/bash

mysql_cmd="mysql"
mysql_user="root"
mysql_pwd="test1234"

read -p "Please enter database name: " db_name

echo "Drop database ${db_name} if exists"
"${mysql_cmd}" -u"${mysql_user}" -p"${mysql_pwd}" -e "DROP DATABASE IF EXISTS ${db_name};"

echo "Create database ${db_name}"
"${mysql_cmd}" -u"${mysql_user}" -p"${mysql_pwd}" -e "CREATE DATABASE ${db_name};"

echo "Finish"

