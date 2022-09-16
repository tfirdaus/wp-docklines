FROM composer:2 AS composer
FROM wordpress:cli-2.6 AS wp-cli
FROM wordpress:php7.3-fpm

LABEL org.opencontainers.image.source https://github.com/tfirdaus/wp-docklines

# Install extra packages
RUN set -ex; \
	apt-get update \
	&& EXTRA_PACKAGES=" \
		default-mysql-client \
		unzip \
		subversion \
		git \
		ssh \
	" \
	&& apt-get install -y $EXTRA_PACKAGES --no-install-recommends \
	&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/*

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
