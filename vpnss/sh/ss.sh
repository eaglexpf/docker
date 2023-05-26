#!/bin/bash

if [ -n "$ENV_SS_CLIENT" ]; then
  go-shadowsocks2 -c "$ENV_SS_CLIENT" -verbose -socks ":$ENV_SS_LOCAL_PORT"
fi