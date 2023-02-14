FROM bcit.io/alpine:3.17-latest

ENV DISABLE_EXTENSIONS="curl enchant ftp gd imagick imap ldap odbc pcntl snmp ssh2 sysvmsg sysvsem sysvshm exif pdo_odbc amqp mailparse vips xdebug"
ENV ENABLE_EXTENSIONS=""

RUN apk add --no-cache \
    php81 \
    php81-bcmath \
    php81-bz2 \
    php81-calendar \
    php81-ctype \
    php81-curl \
    php81-dba \
    php81-dom \
    php81-enchant \
    php81-exif \
    php81-fileinfo \
    php81-fpm \
    php81-ftp \
    php81-gd \
    php81-gettext \
    php81-gmp \
    php81-iconv \
    php81-imap \
    php81-intl \
    php81-json \
    php81-ldap \
    php81-mbstring \
    php81-mysqli \
    php81-mysqlnd \
    php81-opcache \
    php81-odbc \
    php81-openssl \
    php81-pcntl \
    php81-pdo \
    php81-pdo_dblib \
    php81-pdo_mysql \
    php81-pdo_odbc \
    php81-pdo_pgsql \
    php81-pdo_sqlite \
    php81-pecl-amqp \
    php81-pecl-event \
    php81-pecl-igbinary \
    php81-pecl-imagick \
    php81-pecl-lzf \
    php81-pecl-mailparse \
    # php81-pecl-mcrypt \
    php81-pecl-memcached \
    php81-pecl-msgpack \
    # php81-pecl-oauth \
    php81-pecl-protobuf \
    php81-pecl-redis \
    php81-pecl-ssh2 \
    # php81-pecl-timezonedb \
    php81-pecl-vips \
    php81-pecl-xdebug \
    php81-pecl-yaml \
    # php81-pecl-zmq \
    php81-pgsql \
    php81-phar \
    php81-posix \
    php81-pspell \
    php81-session \
    php81-shmop \
    php81-simplexml \
    php81-snmp \
    php81-soap \
    php81-sockets \
    php81-sockets \
    php81-sodium \
    php81-sqlite3 \
    php81-sysvmsg \
    php81-sysvsem \
    php81-sysvshm \
    php81-tidy \
    php81-tokenizer \
    php81-xml \
    php81-xmlreader \
    # php81-xmlrpc \
    php81-xmlwriter \
    php81-xsl \
    php81-zip \
    fcgi \
 && rm -rf /var/cache/apk

RUN apk add --no-cache \
    --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    php81-pecl-timezonedb \
    php81-pecl-oauth \
    php81-pecl-xmlrpc \
 && rm -rf /var/cache/apk

ADD https://raw.githubusercontent.com/renatomefi/php-fpm-healthcheck/master/php-fpm-healthcheck /usr/local/bin/php-fpm-healthcheck
ADD www.conf /etc/php81/php-fpm.d/www.conf
ADD docker.conf /etc/php81/php-fpm.d/docker.conf
ADD zz-docker.conf /etc/php81/php-fpm.d/zz-docker.conf
ADD 8.1/50-copy-php-fpm-config.sh /docker-entrypoint.d/50-copy-php-fpm-config.sh
ADD 8.1/60-php_extensions.sh /docker-entrypoint.d/60-php_extensions.sh
ADD php.ini-development /etc/php81/php.ini-development

RUN chmod +x /usr/local/bin/php-fpm-healthcheck \
 && sh -c 'find /etc/php81 -type f -exec chown root:root {} \;' \
 && sh -c 'find /etc/php81 -type f -exec chmod 664 {} \;' \
 && sh -c 'find /etc/php81 -type d -exec chmod root:root {} \;' \
 && sh -c 'find /etc/php81 -type d -exec chmod 775 {} \;' \
 && echo "zend_extension=xdebug.so" > /etc/php81/conf.d/50_xdebug.ini \
 && sed -i 's^;date.timezone =^date.timezone = America/Vancouver^' /etc/php81/php.ini

WORKDIR /application
HEALTHCHECK CMD /usr/local/bin/php-fpm-healthcheck

CMD ["/usr/sbin/php-fpm81", "-F", "-O", "-y", "/etc/php81/php-fpm.conf"]
