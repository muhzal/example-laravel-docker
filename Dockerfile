FROM php:7.0.31-apache

RUN apt-get update && apt-get install -y \
    build-essential \
    mysql-client \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    curl \
    git \
    libcurl3 libcurl3-dev \
    libmcrypt-dev \
    jpegoptim optipng pngquant gifsicle

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Installing extensions
RUN docker-php-ext-install pdo_mysql zip exif pcntl mysqli mcrypt
RUN docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/
RUN docker-php-ext-install gd

# Install xdebug
RUN pecl install xdebug-2.5.0
RUN docker-php-ext-enable xdebug

# Installing composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Allow container to write on host
RUN usermod -u 1000 www-data

# Enable apache modules
RUN a2enmod proxy rewrite headers

# Changing Workdir
WORKDIR /var/www/html

# Add project to container
ADD ./src .

# Configure directory permissions for the web server
RUN chgrp -R www-data storage /var/www/html/bootstrap/cache
RUN chmod -R ug+rwx storage /var/www/html/bootstrap/cache

RUN chgrp -R www-data storage /var/www/html/storage
RUN chmod -R ug+rwx storage /var/www/html/storage

# Install Dependencies
RUN composer install