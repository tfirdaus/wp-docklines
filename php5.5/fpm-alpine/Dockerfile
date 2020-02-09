FROM php:5.5-fpm-alpine

# docker-entrypoint.sh dependencies
RUN set -ex; \
	apk add --no-cache \
# in theory, docker-entrypoint.sh is POSIX-compliant, but priority is a working, consistent image
		bash \
# BusyBox sed is not sufficient for some of our sed expressions
		sed

# install the PHP extensions we need
RUN set -ex; \
	\
	apk add --no-cache --virtual .build-deps \
		libjpeg-turbo-dev \
		libpng-dev \
	; \
	\
	docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
	docker-php-ext-install gd mysqli opcache; \
	\
	runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)"; \
	apk add --virtual .wordpress-phpexts-rundeps $runDeps; \
	apk del .build-deps

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=2'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

VOLUME /var/www/html

ENV WORDPRESS_VERSION 4.9.4
ENV WORDPRESS_SHA1 0e630bf940fd586b10e099cd9195b3e825fb194c

# Upstream tarballs include ./wordpress/ so this gives us /usr/src/wordpress
RUN set -ex; \
	curl -o wordpress.tar.gz -fSL "https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz"; \
	echo "$WORDPRESS_SHA1 *wordpress.tar.gz" | sha1sum -c -; \
	tar -xzf wordpress.tar.gz -C /usr/src/; \
	rm wordpress.tar.gz; \
	chown -R www-data:www-data /usr/src/wordpress

##<wp-docklines>##
# Install extra packages
RUN set -ex; \
	apk add --update --no-cache mysql-client openssh-client unzip subversion git

# Install and enable extra PHP extensions.
RUN docker-php-ext-install mysqli pdo pdo_mysql && \
	docker-php-ext-enable mysqli pdo pdo_mysql

# Install WP-CLI
ENV WP_CLI_VERSION 2.0.1
ENV WP_CLI_SHA512 21b9c1d65993f88bf81cc73c0a832532cc424bea8c15563a77af1905d0dc4714f2af679dfadedd3b683f3968902b4b6be4c6cf94285da9f5582b30c1dac5397f

RUN set -ex; \
	curl -o /usr/local/bin/wp.phar -fSL "https://github.com/wp-cli/wp-cli/releases/download/v${WP_CLI_VERSION}/wp-cli-${WP_CLI_VERSION}.phar" \
	&& echo "$WP_CLI_SHA512 */usr/local/bin/wp.phar" | sha512sum -c - \
	&& chmod +x /usr/local/bin/wp.phar \
	&& mv /usr/local/bin/wp.phar /usr/local/bin/wp \
	&& mkdir -p /var/www/.wp-cli && chown www-data:www-data -R /var/www/.wp-cli \
	&& wp cli info

# Install PHPUnit
# SHA256 source: https://phar.phpunit.de/
ENV PHPUNIT_VERSION 4.8.36
ENV PHPUNIT_SHA256 ab8bc3017a64cf75a2112f5e089a1d5b0c4cc2116556d60c1af5e3f584e85c5e

RUN set -ex; \
	curl -o /usr/local/bin/phpunit.phar -fSL "https://phar.phpunit.de/phpunit-${PHPUNIT_VERSION}.phar" \
	&& echo "$PHPUNIT_SHA256 */usr/local/bin/phpunit.phar" | sha256sum -c - \
	&& chmod +x /usr/local/bin/phpunit.phar \
	&& mv /usr/local/bin/phpunit.phar /usr/local/bin/phpunit \
	&& phpunit --version

# Install PHP CodeSniffer && WordPress Coding Standards
# SHA256 source: https://squizlabs.github.io/PHP_CodeSniffer/phars/phive.xml
ENV PHPCS_VERSION 3.3.2
ENV PHPCS_SHA256 692a281f40b0afa3120f25e195102d0d327efef5ef16ce18cb9e5731a45ee35a

ENV PHPCBF_VERSION $PHPCS_VERSION
ENV PHPCBF_SHA256 c43e2e924bf28eb48f825df12a9031ad4a96bf2e2e609ce78ad2653ce969ace3

ENV WPCS_VERSION 1.2.0

RUN set -ex; \
	curl -o /usr/local/bin/phpcs.phar -fSL "https://github.com/squizlabs/PHP_CodeSniffer/releases/download/${PHPCS_VERSION}/phpcs.phar" \
	&& echo "$PHPCS_SHA256 */usr/local/bin/phpcs.phar" | sha256sum -c - \
	&& chmod +x /usr/local/bin/phpcs.phar \
	&& mv /usr/local/bin/phpcs.phar /usr/local/bin/phpcs \
	&& curl -o /usr/local/bin/phpcbf.phar -fSL "https://github.com/squizlabs/PHP_CodeSniffer/releases/download/${PHPCBF_VERSION}/phpcbf.phar" \
	&& echo "$PHPCBF_SHA256 */usr/local/bin/phpcbf.phar" | sha256sum -c - \
	&& chmod +x /usr/local/bin/phpcbf.phar \
	&& mv /usr/local/bin/phpcbf.phar /usr/local/bin/phpcbf \
	&& phpcs --version \
	&& phpcbf --version \
	&& curl -o wpcs.tar.gz -fSL "https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards/archive/${WPCS_VERSION}.tar.gz" \
	&& mkdir -p /var/wpcs \
	&& tar -xzf wpcs.tar.gz --directory /var/wpcs --strip-components 1 && rm wpcs.tar.gz \
	&& phpcs --config-set show_progress 1 \
	&& phpcs --config-set colors 1 \
	&& phpcs --config-set installed_paths /var/wpcs
##</wp-docklines>##

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
