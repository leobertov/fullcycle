FROM php:7.3.6-fpm-alpine3.9

RUN apk add --no-cache shadow
RUN apk add bash mysql-client
RUN docker-php-ext-install pdo pdo_mysql

RUN rm -rf /usr/local/etc/php-fpm.d/ww.conf
COPY ./www.conf /usr/local/etc/php-fpm.d/

WORKDIR /var/www
RUN rm -rf /var/www/html


#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin 
#RUN cp -p /usr/local/bin/composer.phar /usr/local/bin/composer
#RUN composer install && \
#            cp .env.example .env && \
#            php artisan key:generate && \
#            php artisan config:cache



COPY ./laravel /var/www
RUN ln -s public html

#RUN chown -R www-data:www-data /var/www
#RUN usermod -u 1000 www-data
#USER www-data

EXPOSE 9000

ENTRYPOINT [ "php-fpm" ]