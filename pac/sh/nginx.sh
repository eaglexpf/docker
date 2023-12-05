#!/bin/bash

# 创建配置文件
cat > /etc/nginx/http.d/default.conf <<EOF
server {
    listen 80;
    root /var/www/localhost;

    location / {
        index index.html;
    }
}
EOF

nginx -g 'daemon off;'