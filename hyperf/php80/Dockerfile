FROM alpine:3.16

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
    php8 \
    php8-bcmath \
    php8-curl \
    php8-ctype \
    php8-dev \
    php8-dom \
    php8-fileinfo \
    php8-gd \
    php8-iconv \
    php8-mbstring \
    php8-mysqlnd \
    php8-openssl \
    php8-pdo \
    php8-pdo_mysql \
    php8-pdo_sqlite \
    php8-phar \
    php8-posix \
    php8-sockets \
    php8-sodium \
    php8-sysvshm \
    php8-sysvmsg \
    php8-sysvsem \
    php8-simplexml \
    php8-tokenizer \
    php8-zip \
    php8-zlib \
    php8-xml \
    php8-xmlreader \
    php8-xmlwriter \
    php8-pcntl \
    php8-opcache \
    php8-pecl-redis \
    php8-pecl-mongodb \
    php8-pecl-swoole \
    && ln -sf /usr/bin/php8 /usr/bin/php \
    # install memcached
    && apk add --no-cache libmemcached-dev cyrus-sasl-dev gcc make autoconf libc-dev \
    && wget -O memcached.tar.gz https://pecl.php.net/get/memcached-3.2.0.tgz \
    && mkdir -p /usr/src/memcached \
    && tar -xzf memcached.tar.gz -C /usr/src/memcached --strip-components=1 \
    && rm memcached.tar.gz \
    && cd /usr/src/memcached \
    && phpize8 \
    && ./configure --enable-memcached-sasl --enable-memcached-igbinary --enable-memcached-json \
    && make && make install \
    && echo "extension=memcached" > /etc/php8/conf.d/90_memcached.ini \
    && echo "memcached.use_sasl=1" >> /etc/php8/conf.d/90_memcached.ini \
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
    } | tee /etc/php8/conf.d/90_customize.ini \
    # - config timezone
    && ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone \
    # 清理工作
    && rm -rf /var/cache/apk/*

EXPOSE 9501
