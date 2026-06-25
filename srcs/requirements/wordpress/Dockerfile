FROM alpine:3.19

RUN apk update && apk add --no-cache \
    php82 \
    php82-fpm \
    php82-mysqli \
    php82-phar \
    php82-mbstring \
    php82-curl \
    php82-dom \
    php82-exif \
    php82-fileinfo \
    php82-xml \
    php82-zip \
    mariadb-client \
    curl \
    wget

RUN ln -sf /usr/bin/php82 /usr/bin/php
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html && chown -R nobody:nobody /var/www/html

COPY conf/www.conf /etc/php82/php-fpm.d/www.conf
COPY tools/entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/tmp/entrypoint.sh"]

CMD ["php-fpm82", "-F"]