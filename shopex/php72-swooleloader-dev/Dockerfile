FROM php:7.2-fpm

LABEL maintainer="eaglexpf <1121252990@qq.com>"

ENV TIMEZONE=${timezone:-"Asia/Shanghai"} \
    COMPOSER_VERSION=2.0.2

ADD swoole_loader/swoole_loader72.so /usr/local/lib/php/extensions/no-debug-non-zts-20170718/

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

# 使用 阿里源 替换
RUN sed -i "s@http://deb.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list \
    && sed -i "s@http://security.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list \
    && rm -rf /var/lib/apt/lists/* && apt update && apt install -y nginx cron supervisor git vim wget \
    && cd /tmp && wget https://github.com/composer/composer/releases/download/${COMPOSER_VERSION}/composer.phar \
    && chmod u+x composer.phar && mv composer.phar /usr/local/bin/composer \
    && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
    
# install php extensions
RUN install-php-extensions bcmath gd gettext mcrypt mysqli redis memcached pcntl \
    pdo_mysql shmop soap sockets sysvsem zip mongodb \
    #  ---------- some config ----------
    && cd /usr/local/etc/php \
    # - config PHP
    && { \
        echo "upload_max_filesize=100M"; \
        echo "post_max_size=108M"; \
        echo "memory_limit=-1"; \
        echo "date.timezone=${TIMEZONE}"; \
        echo "always_populate_raw_post_data=-1"; \
    } | tee conf.d/99_overrides.ini \
    && { \
        echo "extension=swoole_loader72.so"; \
        echo "swoole_license_files=/var/www/html/license.zl"; \
    } | tee conf.d/swoole_loader.ini \
    # - config timezone
    && ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone \
    && php -a

ADD conf/php_fcgi.conf /etc/nginx/php_fcgi.conf
ADD conf/pathinfo.conf /etc/nginx/pathinfo.conf
ADD conf/default.conf /etc/nginx/conf.d/default.conf
ADD conf/nginx.conf /etc/nginx/nginx.conf
ADD conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ADD sh/ /sh/
RUN chmod -R +x /sh
CMD ["/sh/start.sh"]