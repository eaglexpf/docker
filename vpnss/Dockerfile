FROM golang:1.20-alpine as build-stage

RUN go env -w GO111MODULE=on && go env -w GOPROXY=https://goproxy.cn,direct \
	&& go install github.com/shadowsocks/go-shadowsocks2@latest

FROM hwdsl2/ipsec-vpn-server as production-stage

LABEL maintainer="eaglexpf <1121252990@qq.com>"

COPY --from=build-stage /go/bin/* /usr/local/bin

ENV TZ=Asia/Shanghai

ADD ./sh /sh
ADD ./supervisor /etc/supervisor.d

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk update \
    && apk add tzdata git nginx supervisor curl \
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
    && apk del git \
    && rm -rf /var/cache/apk/* \
    && chmod -R 755 /sh

CMD /usr/bin/supervisord -n -c /etc/supervisord.conf