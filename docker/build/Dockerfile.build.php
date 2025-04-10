FROM php:8.1-cli

# Install dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev \
    git \
    zip \
    tar \
    unzip \
    php-mysql \
    && docker-php-ext-install pdo_pgsql

WORKDIR /app

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY backend /app

CMD [ "bash start.sh" ]