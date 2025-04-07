FROM php:8.1-cli

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev \
    git \
    zip \
    tar \
    unzip \
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql

# Set working directory
WORKDIR /app

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Keep the container running (for development or debugging)
CMD ["sleep", "infinity"]
