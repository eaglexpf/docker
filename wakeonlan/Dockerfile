FROM alpine:3.18

LABEL maintainer="eaglexpf <1121252990@qq.com>"

RUN set -ex \
	# 替换国内源
	&& sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk update \
	&& apk add python3 py3-pip \
	&& pip3 install wakeonlan