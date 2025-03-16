# Use the official WordPress image with PHP 8.0 and Apache
FROM wordpress:php8.0-apache

# Update and install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    && apt-get clean

# Install Composer (a PHP dependency manager)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install magic-wormhole (as in your original request)
RUN apt-get update && apt-get install -y magic-wormhole

# Switch to www-data user
RUN usermod -s /bin/bash www-data
RUN chown -R www-data:www-data /var/www

# Set the working directory
WORKDIR /var/www/html

# Install firebase/php-jwt using Composer
RUN composer require firebase/php-jwt

# Switch to www-data user
USER www-data

# Expose port 80
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]
