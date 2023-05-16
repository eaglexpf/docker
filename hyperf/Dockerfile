FROM alpine:3.17

LABEL maintainer="eaglexpf <1121252990@qq.com>"

ENV TIMEZONE=${timezone:-"Asia/Shanghai"}

RUN set -ex \
	# 替换国内源
	&& sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk update \
    && apk add --upgrade --no-cache \
    ca-certificates \
    curl \
    composer \
    wget \
    tar \
    xz \
    tzdata \
    pcre \
    php81 \
    php81-bcmath \
    php81-curl \
    php81-ctype \
    php81-dev \
    php81-dom \
    php81-fileinfo \
    php81-gd \
    php81-iconv \
    php81-mbstring \
    php81-mysqlnd \
    php81-openssl \
    php81-pdo \
    php81-pdo_mysql \
    php81-pdo_sqlite \
    php81-phar \
    php81-posix \
    php81-sockets \
    php81-sodium \
    php81-sysvshm \
    php81-sysvmsg \
    php81-sysvsem \
    php81-simplexml \
    php81-tokenizer \
    php81-zip \
    php81-zlib \
    php81-xml \
    php81-xmlreader \
    php81-xmlwriter \
    php81-pcntl \
    php81-opcache \
    php81-pecl-redis \
    php81-pecl-mongodb \
    php81-pecl-swoole \
    && ln -sf /usr/bin/php81 /usr/bin/php \
    # install memcached
    && apk add --no-cache libmemcached-dev cyrus-sasl-dev gcc make autoconf libc-dev \
    && wget -O memcached.tar.gz https://pecl.php.net/get/memcached-3.2.0.tgz \
    && mkdir -p /usr/src/memcached \
    && tar -xzf memcached.tar.gz -C /usr/src/memcached --strip-components=1 \
    && rm memcached.tar.gz \
    && cd /usr/src/memcached \
    && phpize81 \
    && ./configure --enable-memcached-sasl --enable-memcached-igbinary --enable-memcached-json \
    && make && make install \
    && echo "extension=memcached" > /etc/php81/conf.d/90_memcached.ini \
    && echo "memcached.use_sasl=1" >> /etc/php81/conf.d/90_memcached.ini \
    # config composer
    && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ \
    # config php
    && { \
        echo "upload_max_filesize=128M"; \
        echo "post_max_size=128M"; \
        echo "memory_limit=1G"; \
        echo "date.timezone=${TIMEZONE}"; \
        echo "opcache.enable_cli = 'On'"; \
        echo "swoole.use_shortname = 'Off'"; \
    } | tee /etc/php81/conf.d/90_customize.ini \
    # - config timezone
    && ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone \
    # 清理工作
    && rm -rf /var/cache/apk/*

EXPOSE 9501
