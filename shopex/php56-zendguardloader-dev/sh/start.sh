#!/bin/bash

# Set custom license_path
if [ ! -z "$LICENSE_PATH" ]; then
 sed -i "s#zend_loader.license_path=/zend_loader/license/#zend_loader.license_path=${LICENSE_PATH}#g" /etc/local/lib/php/conf.d/zend_loader.ini
else
 license_path=/zend_loader/license/
fi

chown -R www-data:www-data /var/www/html 
chmod -R 777 /var/www/html

exec /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf