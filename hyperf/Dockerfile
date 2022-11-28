FROM php:8.1-cli-alpine3.16

LABEL maintainer="eaglexpf <1121252990@qq.com>"

ENV TIMEZONE=${timezone:-"Asia/Shanghai"} \
	PHPIZE_DEPS="autoconf dpkg-dev dpkg file g++ gcc libc-dev make pkgconf re2c pcre-dev pcre2-dev zlib-dev libtool automake libaio-dev openssl-dev curl-dev"

RUN set -ex \

	# 替换国内源
	&&sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk update \

	# 安装composer
	&& apk add --no-cache composer \
    && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ \

	# 安装 bcmath,pcntl,pdo_mysql,sysvmsg,sysvsem,sysvshm 扩展
	&& docker-php-ext-install bcmath pcntl pdo_mysql sysvmsg sysvsem sysvshm \

	# 开启 opcache 扩展
	&& docker-php-ext-enable opcache \

	# 安装pecl依赖
    && apk add --no-cache libstdc++ openssl git bash c-ares-dev libpq-dev \
    && apk add --no-cache --virtual .build-pecl-deps $PHPIZE_DEPS \

	# 安装 gd 扩展
	&& apk add --no-cache --virtual .build-gd-deps freetype-dev libjpeg-turbo-dev libpng-dev libxpm-dev libwebp-dev \
	&& docker-php-ext-configure gd --enable-gd --with-webp --with-jpeg --with-xpm --with-freetype \
	&& docker-php-ext-install gd \
	&& apk del .build-gd-deps \
	&& apk add --no-cache freetype libjpeg-turbo libpng libxpm libwebp \

	# 安装 sockets 扩展
	&& apk add --no-cache --virtual .build-sockets-deps linux-headers \
	&& docker-php-ext-install sockets \
	&& apk del .build-sockets-deps \

	# 安装 zip 扩展
	&& apk add --no-cache --virtual .build-zip-deps cmake gnutls-dev libzip-dev libretls-dev \
	&& docker-php-ext-configure zip --with-zip \
	&& docker-php-ext-install zip \
	&& apk del .build-zip-deps \
	&& apk add --no-cache libzip \

	# 安装 redis 扩展
	&& pecl install redis \
	&& docker-php-ext-enable redis \

	# 安装 memcached 扩展
	&& apk add --no-cache --virtual .build-memcached-deps libmemcached-dev \
	&& pecl install memcached \
	&& docker-php-ext-enable memcached \
	&& apk del .build-memcached-deps \
	&& apk add --no-cache libmemcached-libs \

	# 安装 swoole 扩展
	&& pecl install --configureoptions 'enable-sockets="no" enable-openssl="yes" enable-http2="yes" enable-mysqlnd="yes" enable-swoole-json="no" enable-swoole-curl="yes" enable-cares="yes"' swoole \
	&& docker-php-ext-enable swoole \

	# 删除pecl依赖
	&& apk del .build-pecl-deps \


    #  ---------- some config ----------
    # - config PHP
    && { \
        echo "upload_max_filesize=128M"; \
        echo "post_max_size=128M"; \
        echo "memory_limit=1G"; \
        echo "date.timezone=${TIMEZONE}"; \
    } | tee /usr/local/etc/php/conf.d/docker.ini \
    && echo "opcache.enable_cli = 'On'" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
    && echo "swoole.use_shortname = 'Off'" >> /usr/local/etc/php/conf.d/docker-php-ext-swoole.ini \
    # - config timezone
    && apk add tzdata \
    && ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone
