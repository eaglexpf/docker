FROM alpine:3.17

LABEL maintainer="eaglexpf <1121252990@qq.com>"

ENV TIMEZONE=${timezone:-"Asia/Shanghai"}

RUN set -ex \
	# 替换国内源
	&& sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk update \

    && apk add --upgrade --no-cache \
    # Install base packages ('ca-certificates' will install 'nghttp2-libs')
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
    php81-pecl-memcached \
    php81-pecl-mongodb \
    php81-pecl-swoole \
    && ln -sf /usr/bin/php81 /usr/bin/php \
    && apk del --purge *-dev \

    # config composer
    && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ \

    # config php
    && { \
        echo "upload_max_filesize=128M"; \
        echo "post_max_size=128M"; \
        echo "memory_limit=1G"; \
        echo "date.timezone=${TIMEZONE}"; \
    } | tee /etc/php81/conf.d/00_customize.ini \
    && echo "opcache.enable_cli = 'On'" >> /etc/php81/conf.d/00_customize.ini \
    && echo "swoole.use_shortname = 'Off'" >> /etc/php81/conf.d/00_customize.ini \

    # - config timezone
    && ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone




