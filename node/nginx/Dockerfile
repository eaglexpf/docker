FROM node:18

LABEL maintainer="eaglexpf <1121252990@qq.com>"

ENV TIMEZONE=${timezone:-"Asia/Shanghai"}

RUN cp /etc/apt/sources.list.d/debian.sources /etc/apt/sources.list.d/debian.sources.tmp \
	&& sed -i "s@http://deb.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list.d/debian.sources \
	&& sed -i "s@http://security.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list.d/debian.sources \
	&& rm -rf /var/lib/apt/lists/* && apt update && apt install -y nginx

CMD ["nginx", "-g", "daemon off;"]