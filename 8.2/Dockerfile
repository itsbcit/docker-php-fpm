FROM bcit.io/alpine:3.18-latest

ENV DISABLE_EXTENSIONS="curl enchant ftp gd imagick imap ldap odbc pcntl snmp ssh2 sysvmsg sysvsem sysvshm exif pdo_odbc amqp mailparse vips xdebug"
ENV ENABLE_EXTENSIONS=""

RUN apk add --no-cache \
    --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community \
    php82 \
    php82-bcmath \
    php82-bz2 \
    php82-calendar \
    php82-ctype \
    php82-curl \
    php82-dba \
    php82-dom \
    php82-enchant \
    php82-exif \
    php82-fileinfo \
    php82-fpm \
    php82-ftp \
    php82-gd \
    php82-gettext \
    php82-gmp \
    php82-iconv \
    php82-imap \
    php82-intl \
    php82-json \
    php82-ldap \
    php82-mbstring \
    php82-mysqli \
    php82-mysqlnd \
    php82-opcache \
    php82-odbc \
    php82-openssl \
    php82-pcntl \
    php82-pdo \
    php82-pdo_dblib \
    php82-pdo_mysql \
    php82-pdo_odbc \
    php82-pdo_pgsql \
    php82-pdo_sqlite \
    # php82-pecl-amqp \
    # php82-pecl-event \
    php82-pecl-igbinary \
    # php82-pecl-imagick \
    # php82-pecl-lzf \
    # php82-pecl-mailparse \
    # php82-pecl-mcrypt \
    php82-pecl-memcached \
    php82-pecl-msgpack \
    # php82-pecl-oauth \
    # php82-pecl-protobuf \
    php82-pecl-redis \
    # php82-pecl-ssh2 \
    # php82-pecl-timezonedb \
    # php82-pecl-vips \
    php82-pecl-xdebug \
    php82-pecl-yaml \
    # php82-pecl-zmq \
    php82-pgsql \
    php82-phar \
    php82-posix \
    php82-pspell \
    php82-session \
    php82-shmop \
    php82-simplexml \
    php82-snmp \
    php82-soap \
    php82-sockets \
    php82-sockets \
    php82-sodium \
    php82-sqlite3 \
    php82-sysvmsg \
    php82-sysvsem \
    php82-sysvshm \
    php82-tidy \
    php82-tokenizer \
    php82-xml \
    php82-xmlreader \
    # php82-xmlrpc \
    php82-xmlwriter \
    php82-xsl \
    php82-zip \
    fcgi \
 && rm -rf /var/cache/apk


RUN apk add --no-cache \
    --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    php82-pecl-amqp \
    php82-pecl-imagick \
    php82-pecl-lzf \
    php82-pecl-oauth \
    php82-pecl-protobuf \
    php82-pecl-timezonedb \
    php82-pecl-vips \
    # php82-xmlrpc \
 && rm -rf /var/cache/apk
ADD https://raw.githubusercontent.com/renatomefi/php-fpm-healthcheck/master/php-fpm-healthcheck /usr/local/bin/php-fpm-healthcheck
ADD www.conf /etc/php82/php-fpm.d/www.conf
ADD docker.conf /etc/php82/php-fpm.d/docker.conf
ADD zz-docker.conf /etc/php82/php-fpm.d/zz-docker.conf
ADD 8.2/50-copy-php-fpm-config.sh /docker-entrypoint.d/50-copy-php-fpm-config.sh
ADD 8.2/60-php_extensions.sh /docker-entrypoint.d/60-php_extensions.sh
ADD php.ini-development /etc/php82/php.ini-development
RUN sed -i 's$.*;error_log.*$&\nerror_log = /dev/stderr$' /etc/php82/php-fpm.conf

RUN chmod +x /usr/local/bin/php-fpm-healthcheck \
 && sh -c 'find /etc/php82 -type f -exec chown root:root {} \;' \
 && sh -c 'find /etc/php82 -type f -exec chmod 664 {} \;' \
 && sh -c 'find /etc/php82 -type d -exec chmod root:root {} \;' \
 && sh -c 'find /etc/php82 -type d -exec chmod 775 {} \;' \
 && echo "zend_extension=xdebug.so" > /etc/php82/conf.d/50_xdebug.ini \
 && sed -i 's^;date.timezone =^date.timezone = America/Vancouver^' /etc/php82/php.ini

WORKDIR /application
HEALTHCHECK CMD /usr/local/bin/php-fpm-healthcheck

CMD ["/usr/sbin/php-fpm82", "-F", "-O", "-y", "/etc/php82/php-fpm.conf"]
