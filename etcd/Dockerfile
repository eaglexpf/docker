FROM golang:1.20 as build-stage

ENV ETCD_VERSION=3.5.0

RUN set -ex \
	&& sed -i "s@http://deb.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list \
    && sed -i "s@http://security.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list \
    && rm -rf /var/lib/apt/lists/* && apt update \
	&& apt install unzip \
	&& cd / \
    && wget https://github.com/etcd-io/etcd/archive/v${ETCD_VERSION}.zip \
    && unzip v${ETCD_VERSION}.zip \
    && cd /etcd-${ETCD_VERSION} \
    && go env -w GO111MODULE=on \
    && go env -w GOPROXY=https://goproxy.cn,direct \
    && ./build.sh

FROM alpine:3.17 as production-stage

LABEL maintainer="eaglexpf <1121252990@qq.com>"

ENV TIMEZONE=${timezone:-"Asia/Shanghai"} \
	ETCD_VERSION=3.5.0

COPY --from=build-stage /etcd-${ETCD_VERSION}/bin/* /usr/local/bin

RUN export PATH="$PATH:/usr/local/etcd"

EXPOSE 2379 2380

CMD etcd