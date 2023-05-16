# 设置全局http代理
```
export http_proxy=socks5://127.0.0.1:1080
export https_proxy=socks5://127.0.0.1:1080
```

# curl直接代理
```
curl -x socks5://127.0.0.1:1080 https://www.baidu.com
```