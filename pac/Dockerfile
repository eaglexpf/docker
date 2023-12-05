FROM golang:1.20-alpine

LABEL maintainer="eaglexpf <1121252990@qq.com>"

ENV TZ=Asia/Shanghai

ADD ./sh /sh
ADD ./supervisor /etc/supervisor.d

# 安装ss
RUN go env -w GO111MODULE=on && go env -w GOPROXY=https://goproxy.cn,direct \
	&& go install github.com/shadowsocks/go-shadowsocks2@latest \
	# 安装pac相关服务
	&& sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk update \
    && apk add tzdata curl nginx nginx-mod-http-lua supervisor bash \
	# 设置时区
    && ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone \
    # 安装python3.8
    && mkdir /data && cd /data \
	&& apk add wget ca-certificates gnupg libffi-dev openssl-dev build-base zlib-dev \
	&& wget https://www.python.org/ftp/python/3.8.12/Python-3.8.12.tgz \
	&& tar -zxvf Python-3.8.12.tgz \
	&& cd Python-3.8.12 \
	&& ./configure --enable-optimizations \
	&& make altinstall \
	&& rm /data/Python-3.8.12.tgz \
	# 安装genpac
	&& cd /data \
	&& wget https://github.com/JinnLynn/genpac/archive/refs/tags/v2.0.1.tar.gz \
	&& tar -zxvf v2.0.1.tar.gz \
	&& cd genpac-2.0.1 \
    && python3.8 setup.py install \
    && apk del wget ca-certificates gnupg libffi-dev openssl-dev build-base zlib-dev \
    && rm /data/v2.0.1.tar.gz \
    # 清理工作
    && rm -rf /var/cache/apk/* \
    && chmod -R 755 /sh

CMD /usr/bin/supervisord -n -c /etc/supervisord.conf