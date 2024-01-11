#!/bin/bash

bash autoindex.sh

service php7.3-fpm start
#/etc/init.d/php7.3-fpm start
service mysql start
echo "CREATE DATABASE IF NOT EXISTS wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password
echo "update mysql.user set plugin = 'mysql_native_password' where user='root';" | mysql -u root
mkdir /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -nodes -out /etc/nginx/ssl/html.pem -keyout /etc/nginx/ssl/html.key -subj "/C=IT/ST=Rome/L=Rome/O=42 School/OU=swag@swag.com/CN=localhost"
service nginx start
