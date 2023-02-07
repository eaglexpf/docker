FROM php:7.4-fpm

LABEL maintainer="eaglexpf <1121252990@qq.com>"

ENV TIMEZONE=${timezone:-"Asia/Shanghai"}

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

# 使用 阿里源 替换
RUN sed -i "s@http://deb.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list \
    && sed -i "s@http://security.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list \
    && rm -rf /var/lib/apt/lists/* && apt update \
    && apt install -y nginx cron supervisor git vim wget \
    && cd /tmp && wget https://mirrors.aliyun.com/composer/composer.phar \
    && chmod u+x composer.phar && mv composer.phar /usr/local/bin/composer \
    && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
    
# install php extensions
RUN install-php-extensions bcmath gd gettext mcrypt mysqli redis memcached pcntl \
    pdo_mysql shmop soap sockets sysvsem zip \
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
    # - config timezone
    && ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone \
    && php -a

ADD conf/php_fcgi.conf /etc/nginx/php_fcgi.conf
ADD conf/pathinfo.conf /etc/nginx/pathinfo.conf
ADD conf/default.conf /etc/nginx/conf.d/default.conf
ADD conf/nginx.conf /etc/nginx/nginx.conf
ADD conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]