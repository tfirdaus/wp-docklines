FROM wordpress:php8.0-fpm-alpine
FROM composer:2 AS composer
FROM wordpress:cli-2.6 AS wp-cli

LABEL org.opencontainers.image.source https://github.com/tfirdaus/wp-docklines

# Install extra packages
RUN set -ex; \
	apk add --update --no-cache mysql-client openssh-client unzip subversion git

# Install and enable extra PHP extensions.
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Install wp-cli
COPY --from=wp-cli /usr/local/bin/wp /usr/local/bin/
RUN set -ex; \
    chmod +x /usr/local/bin/wp \
    && wp cli info

# Install composer
ENV COMPOSER_ALLOW_SUPERUSER 1
COPY --from=composer /usr/bin/composer /usr/local/bin/
COPY --from=composer /tmp/keys.* /tmp/
RUN set -ex; \
    chmod +x /usr/local/bin/composer \
    && COMPOSER_HOME=$(composer global config home) \
    && mv /tmp/keys* $COMPOSER_HOME \
    && composer --ansi --version --no-interaction \
    && composer diagnose
