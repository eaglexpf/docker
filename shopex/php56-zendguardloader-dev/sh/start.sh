#!/bin/bash

# Set custom license_path
if [ ! -z "$LICENSE_PATH" ]; then
    sed -i "/zend_loader.license_path=/d" /usr/local/etc/php/conf.d/zend_loader.ini
    sed -i '$a zend_loader.license_path='${LICENSE_PATH}'' /usr/local/etc/php/conf.d/zend_loader.ini
    cat /usr/local/etc/php/conf.d/zend_loader.ini
else
    echo "don't have license_path"
fi

exec /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf