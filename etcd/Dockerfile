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

ENV TZ=Asia/Shanghai \
	ETCD_VERSION=3.5.0

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk update \
    && apk add --no-cache tzdata \
    && ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone

COPY --from=build-stage /etcd-${ETCD_VERSION}/bin/* /usr/local/bin

EXPOSE 2379 2380

CMD etcd