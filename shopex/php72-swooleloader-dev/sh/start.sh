#!/bin/bash

# Set custom license_path
if [ ! -z "$LICENSE_PATH" ]; then
    sed -i "/swoole_license_files=/d" /usr/local/etc/php/conf.d/swoole_loader.ini
    sed -i '$a swoole_license_files='${LICENSE_PATH}'' /usr/local/etc/php/conf.d/swoole_loader.ini
    cat /usr/local/etc/php/conf.d/swoole_loader.ini
else
    echo "don't have license_path"
fi

exec /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf