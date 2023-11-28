#!/bin/bash

if [ -n "$ENV_SS_CLIENT" ]; then
  # 下载gfwlist.txt
  curl -x socks5://127.0.0.1:$ENV_SS_LOCAL_PORT -o /var/www/localhost/gfwlist.txt https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt
  genpac --format=pac --pac-proxy="SOCKS5 $ip:$ENV_SS_LOCAL_PORT" --gfwlist-url=http://127.0.0.1/gfwlist.txt --output=/var/www/localhost/gfwlist.pac

fi

echo "http://$ENV_LOCAL_IP/gfwlist.pac"