FROM bcit.io/alpine:3.14-latest

RUN apk add --no-cache \
    php \
    php-fpm \
    fcgi \
 && rm -rf /var/cache/apk

ADD https://raw.githubusercontent.com/renatomefi/php-fpm-healthcheck/master/php-fpm-healthcheck /usr/local/bin/php-fpm-healthcheck
ADD www.conf /etc/php7/php-fpm.d/www.conf
ADD docker.conf /etc/php7/php-fpm.d/docker.conf
ADD zz-docker.conf /etc/php7/php-fpm.d/zz-docker.conf

RUN chmod +x /usr/local/bin/php-fpm-healthcheck

WORKDIR /application
HEALTHCHECK CMD /usr/local/bin/php-fpm-healthcheck

CMD ["/usr/sbin/php-fpm7", "-F", "-O", "-y", "/etc/php7/php-fpm.conf"]
