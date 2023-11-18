## 使用方法
```
# 1. 配置
# 注：SERVER_DOMAIN_NAME需要替换成实际的域名或者IP，此IP或域名需外网能够访问
docker-compose run --rm openvpn ovpn_genconfig -u udp://SERVER_DOMAIN_NAME

# 2. 初始化，证书相关内容
# Enter New CA Key Passphrase的时候不能为空
docker-compose run --rm openvpn ovpn_initpki

# 3. 启动
docker-compose up -d openvpn

# 4. 生成客户端文件
# `CLIENTNAME`为客户端名称；例如：`export CLIENTNAME="myvpn"`
docker-compose run --rm openvpn easyrsa build-client-full "$CLIENTNAME"

# 5. 导出vpn客户端文件
docker-compose run --rm openvpn ovpn_getclient $CLIENTNAME > $CLIENTNAME.ovpn
```