FROM php:8.2-apache

COPY . /var/www/html

RUN apt-get update -y && apt-get install -y \
    curl \
    git \
    libonig-dev \
    unzip \
    #ref https://qiita.com/vitway/items/660f9121a9c6afbf1047
    && docker-php-ext-install mbstring \
    && rm -rf /var/lib/apt/lists/*

# ref https://getcomposer.org/download/
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === 'c8b085408188070d5f52bcfe4ecfbee5f727afa458b2573b8eaaf77b3419b0bf2768dc67c86944da1544f06fa544fd47') { echo 'Installer verified'.PHP_EOL; } else { echo 'Installer corrupt'.PHP_EOL; unlink('composer-setup.php'); exit(1); }" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer \
    && composer install