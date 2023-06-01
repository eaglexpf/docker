FROM alpine:3.18

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
    php82 \
    php82-bcmath \
    php82-curl \
    php82-ctype \
    php82-dev \
    php82-dom \
    php82-fileinfo \
    php82-gd \
    php82-iconv \
    php82-mbstring \
    php82-mysqlnd \
    php82-openssl \
    php82-pdo \
    php82-pdo_mysql \
    php82-pdo_sqlite \
    php82-phar \
    php82-posix \
    php82-sockets \
    php82-sodium \
    php82-sysvshm \
    php82-sysvmsg \
    php82-sysvsem \
    php82-simplexml \
    php82-tokenizer \
    php82-zip \
    php82-zlib \
    php82-xml \
    php82-xmlreader \
    php82-xmlwriter \
    php82-pcntl \
    php82-opcache \
    php82-pecl-redis \
    php82-pecl-mongodb \
    php82-pecl-swoole \
    && ln -sf /usr/bin/php82 /usr/bin/php \
    # install memcached
    && apk add --no-cache libmemcached-dev cyrus-sasl-dev gcc make autoconf libc-dev \
    && wget -O memcached.tar.gz https://pecl.php.net/get/memcached-3.2.0.tgz \
    && mkdir -p /usr/src/memcached \
    && tar -xzf memcached.tar.gz -C /usr/src/memcached --strip-components=1 \
    && rm memcached.tar.gz \
    && cd /usr/src/memcached \
    && phpize82 \
    && ./configure --enable-memcached-sasl --enable-memcached-igbinary --enable-memcached-json \
    && make && make install \
    && echo "extension=memcached" > /etc/php82/conf.d/90_memcached.ini \
    && echo "memcached.use_sasl=1" >> /etc/php82/conf.d/90_memcached.ini \
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
    } | tee /etc/php82/conf.d/90_customize.ini \
    # - config timezone
    && ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone \
    # 清理工作
    && rm -rf /var/cache/apk/*

EXPOSE 9501
