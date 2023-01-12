ARG PHP_VERSION=8.1
FROM php:${PHP_VERSION} as main-php

# Install dependency
RUN apt-get update && apt-get install -y --no-install-recommends git vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install composer
ARG COMPOSER_VERSION=2
LABEL composer-version=${COMPOSER_VERSION}
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin/ --filename=composer --${COMPOSER_VERSION} \
    && php -r "unlink('composer-setup.php');"\
    && bash -c "\
    if [[ ${COMPOSER_VERSION} =~ \"1\" ]]; then \
        composer global require hirak/prestissimo; \
    fi;"
WORKDIR /app

FROM main-php as dev-image
RUN bash -c 'echo -e "host=localhost" > /app/.pass'


FROM main-php as prod-image
ARG EXTERNAL_HOST=company.com
RUN bash -c "echo -e \"host=${EXTERNAL_HOST}\" > /app/.pass"
RUN curl -o super_remote_config.txt https://ifconfig.me/ \
    && echo -n "\n TO JEST SUPER TAJNA INFORMACJA FIRMY" >> super_remote_config.txt