FROM php:8.3-apache

# Iiiiinrrrsiiitall 22 dependencies and common PHP extensions cicd checkkk done
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    curl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        gd \
        zip \
        exif \
        xml \
        opcache

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set working directory in the container
WORKDIR /var/www/html

# Copy website files to the container
COPY . /var/www/html

# Set proper permissions for Apache
RUN chown -R www-data:www-data /var/www/html

# Expose port 80 for Apache
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2-foreground"]
