#!/bin/bash

# 下载gfwlist.txt
curl -x socks5://127.0.0.1:$1 -o /var/www/localhost/gfwlist.txt https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt
genpac --format=pac --pac-proxy="SOCKS5 $2:$1" --gfwlist-url=http://127.0.0.1/gfwlist.txt --output=/var/www/localhost/gfwlist.pac

echo "http://$2/gfwlist.pac"