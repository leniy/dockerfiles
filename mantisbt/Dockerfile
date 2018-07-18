FROM php:7.0-apache
MAINTAINER Leniy Tsan <m@leniy.org>

RUN a2enmod rewrite

RUN set -xe \
    && apt-get update \
    && apt-get install -yq libpng-dev libjpeg-dev libpq-dev libxml2-dev \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install mbstring mysqli \
    && apt-get clean \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* \
    && rm -rf /var/lib/apt/lists/*

RUN set -xe \
    && curl -fSL "http://jaist.dl.sourceforge.net/project/mantisbt/mantis-stable/2.15.0/mantisbt-2.15.0.tar.gz" -o mantisbt.tar.gz \
    && tar -xz --strip-components=1 -f mantisbt.tar.gz \
    && rm mantisbt.tar.gz

COPY /config_inc.php /var/www/html/config/config_inc.php

RUN set -xe \
    && chown -R www-data:www-data . \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'date.timezone = "Asia/Shanghai"' > /usr/local/etc/php/php.ini
