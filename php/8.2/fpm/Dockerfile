FROM php:8.2-fpm

LABEL maintainer="eaglexpf <1121252990@qq.com>"

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
	# 设置 Composer 使用国内镜像
	&& composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/