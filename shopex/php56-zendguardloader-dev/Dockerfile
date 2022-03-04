FROM php:5.6-fpm

LABEL maintainer="eaglexpf <1121252990@qq.com>"

ENV TIMEZONE=${timezone:-"Asia/Shanghai"}

ADD zend_loader/opcache.so /usr/local/lib/php/extensions/no-debug-non-zts-20131226/
ADD zend_loader/ZendGuardLoader.so /usr/local/lib/php/extensions/no-debug-non-zts-20131226/

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

# 使用 阿里源 替换
RUN sed -i "s@http://deb.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list \
    && sed -i "s@http://security.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list \
    && rm -rf /var/lib/apt/lists/* && apt update && apt install -y nginx cron supervisor git vim
    
# install php extensions
RUN install-php-extensions bcmath gd gettext mcrypt mysql mysqli memcached pcntl \
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
    && { \
        echo "zend_extension=opcache.so"; \
        echo "zend_extension=ZendGuardLoader.so"; \
        echo "zend_loader.enable=1"; \
        echo "zend_loader.disable_licensing=0"; \
        echo "zend_loader.obfuscation_level_support=3"; \
        echo "zend_loader.license_path=/zend_loader/license/developer.zl"; \
    } | tee conf.d/zend_loader.ini \
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