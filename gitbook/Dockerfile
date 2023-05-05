FROM ubuntu:18.04

LABEL maintainer="eaglexpf <1121252990@qq.com>"

RUN set -ex \
    && sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
    && sed -i s@/security.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
    && sed -i s@/ports.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
    && apt-get clean \
    && apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y calibre-bin nodejs npm \
    && npm install -g gitbook-cli \
    && cd /tmp && gitbook init && rm -f /tmp/*.md

WORKDIR /app