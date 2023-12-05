#!/bin/bash

# 创建配置文件
cat > /etc/nginx/http.d/default.conf <<EOF
server {
    listen 80;
    root /var/www/localhost;

    location /pac {
        default_type 'text/plain';
        content_by_lua_block {
            local handle = io.popen('/sh/nginx_pac.sh $ENV_SS_LOCAL_PORT $ENV_LOCAL_IP')
            local result = handle:read('*all')
            handle:close()
            ngx.say(result)
        }
    }

    location / {
        index index.html;
    }
}
EOF

nginx -g 'daemon off;'