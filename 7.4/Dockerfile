FROM bcit.io/alpine:3.15-latest

ENV DISABLE_EXTENSIONS="curl enchant ftp gd imagick imap ldap odbc pcntl snmp ssh2 sysvmsg sysvsem sysvshm exif pdo_odbc amqp mailparse vips xdebug"
ENV ENABLE_EXTENSIONS=""

RUN apk add --no-cache \
    php7 \
    php7-bcmath \
    php7-bz2 \
    php7-calendar \
    php7-ctype \
    php7-curl \
    php7-dba \
    php7-dom \
    php7-enchant \
    php7-exif \
    php7-fileinfo \
    php7-fpm \
    php7-ftp \
    php7-gd \
    php7-gettext \
    php7-gmp \
    php7-iconv \
    php7-imap \
    php7-intl \
    php7-json \
    php7-ldap \
    php7-mbstring \
    php7-mysqli \
    php7-mysqlnd \
    php7-opcache \
    php7-odbc \
    php7-openssl \
    php7-pcntl \
    php7-pdo \
    php7-pdo_dblib \
    php7-pdo_mysql \
    php7-pdo_odbc \
    php7-pdo_pgsql \
    php7-pdo_sqlite \
    php7-pecl-amqp \
    php7-pecl-event \
    php7-pecl-igbinary \
    php7-pecl-imagick \
    php7-pecl-lzf \
    php7-pecl-mailparse \
    php7-pecl-mcrypt \
    php7-pecl-memcached \
    php7-pecl-msgpack \
    php7-pecl-oauth \
    php7-pecl-protobuf \
    php7-pecl-redis \
    php7-pecl-ssh2 \
    php7-pecl-timezonedb \
    php7-pecl-vips \
    php7-pecl-xdebug \
    php7-pecl-yaml \
    php7-pecl-zmq \
    php7-pgsql \
    php7-phar \
    php7-posix \
    php7-pspell \
    php7-session \
    php7-shmop \
    php7-simplexml \
    php7-snmp \
    php7-soap \
    php7-sockets \
    php7-sockets \
    php7-sodium \
    php7-sqlite3 \
    php7-sysvmsg \
    php7-sysvsem \
    php7-sysvshm \
    php7-tidy \
    php7-tokenizer \
    php7-xml \
    php7-xmlreader \
    php7-xmlrpc \
    php7-xmlwriter \
    php7-xsl \
    php7-zip \
    fcgi \
 && rm -rf /var/cache/apk


ADD https://raw.githubusercontent.com/renatomefi/php-fpm-healthcheck/master/php-fpm-healthcheck /usr/local/bin/php-fpm-healthcheck
ADD www.conf /etc/php7/php-fpm.d/www.conf
ADD docker.conf /etc/php7/php-fpm.d/docker.conf
ADD zz-docker.conf /etc/php7/php-fpm.d/zz-docker.conf
ADD 7.4/50-copy-php-fpm-config.sh /docker-entrypoint.d/50-copy-php-fpm-config.sh
ADD 7.4/60-php_extensions.sh /docker-entrypoint.d/60-php_extensions.sh
ADD php.ini-development /etc/php7/php.ini-development
RUN sed -i 's$.*;error_log.*$&\nerror_log = /dev/stderr$' /etc/php7/php-fpm.conf

RUN chmod +x /usr/local/bin/php-fpm-healthcheck \
 && sh -c 'find /etc/php7 -type f -exec chown root:root {} \;' \
 && sh -c 'find /etc/php7 -type f -exec chmod 664 {} \;' \
 && sh -c 'find /etc/php7 -type d -exec chmod root:root {} \;' \
 && sh -c 'find /etc/php7 -type d -exec chmod 775 {} \;' \
 && echo "zend_extension=xdebug.so" > /etc/php7/conf.d/50_xdebug.ini \
 && sed -i 's^;date.timezone =^date.timezone = America/Vancouver^' /etc/php7/php.ini

WORKDIR /application
HEALTHCHECK CMD /usr/local/bin/php-fpm-healthcheck

CMD ["/usr/sbin/php-fpm7", "-F", "-O", "-y", "/etc/php7/php-fpm.conf"]
