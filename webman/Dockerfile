FROM php:7.4-cli

LABEL maintainer="eaglexpf <1121252990@qq.com>"

ENV TIMEZONE=${timezone:-"Asia/Shanghai"}

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

# 使用 阿里源 替换
RUN sed -i "s@http://deb.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list \
    && sed -i "s@http://security.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list \
    && rm -rf /var/lib/apt/lists/* && apt update && apt install -y nginx cron supervisor git vim wget \
    && cd /tmp && wget https://mirrors.aliyun.com/composer/composer.phar \
    && chmod u+x composer.phar && mv composer.phar /usr/local/bin/composer \
    && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

# install php extensions
RUN install-php-extensions bcmath gd gettext mcrypt mysqli redis memcached pcntl \
    pdo_mysql shmop soap sockets sysvsem zip event \
    #  ---------- some config ----------
    && cd /usr/local/etc/php \
    # - config PHP
    && { \
        echo "upload_max_filesize=100M"; \
        echo "post_max_size=100M"; \
        echo "memory_limit=-1"; \
        echo "date.timezone=${TIMEZONE}"; \
        echo "always_populate_raw_post_data=-1"; \
    } | tee conf.d/docker.ini \
    # - config timezone
    && ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone

ADD run.sh /sh/
RUN chmod -R +x /sh
CMD ["/sh/run.sh"]