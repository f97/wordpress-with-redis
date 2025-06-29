FROM wordpress:latest

# Install Redis PHP extension
RUN pecl install redis \
    && docker-php-ext-enable redis

# Enable OPcache for performance
RUN docker-php-ext-enable opcache

# Configure extensions
RUN { \
    echo 'extension=redis.so'; \
    echo 'opcache.enable=1'; \
    echo 'opcache.memory_consumption=128'; \
    echo 'opcache.max_accelerated_files=2000'; \
    } > /usr/local/etc/php/conf.d/performance.ini

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/wp-cli/v2.10.0/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

EXPOSE 80
CMD ["apache2-foreground"]
