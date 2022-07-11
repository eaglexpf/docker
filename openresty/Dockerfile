FROM centos:7

LABEL maintainer="eaglexpf <1121252990@qq.com>"

RUN sed -e 's|^mirrorlist=|#mirrorlist=|g' \
         -e 's|^#baseurl=http://mirror.centos.org/altarch/|baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos-altarch/|g' \
         -e 's|^#baseurl=http://mirror.centos.org/$contentdir/|baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos-altarch/|g' \
         -i.bak \
         /etc/yum.repos.d/CentOS-*.repo && yum makecache && yum update -y

RUN yum install -y supervisor vim wget memcached net-tools telnet

ENV OPENRESTY_VERSION 1.21.4.1

RUN wget https://openresty.org/download/openresty-${OPENRESTY_VERSION}.tar.gz \
	&& yum install -y epel-release gcc pcre pcre-devel zlib zlib-devel openssl openssl-devel \
	&& tar xzf openresty-${OPENRESTY_VERSION}.tar.gz \
	&& cd openresty-${OPENRESTY_VERSION} \
	&& ./configure \
	&& make \
	&& make install \
	&& /usr/local/openresty/bin/openresty -V

ENV PATH=$PATH:/usr/local/openresty/luajit/bin:/usr/local/openresty/nginx/sbin:/usr/local/openresty/bin

RUN groupadd --system --gid 11211 memcache && useradd --system --gid memcache --uid 11211 memcache

CMD ["memcached", "-u", "memcache"]