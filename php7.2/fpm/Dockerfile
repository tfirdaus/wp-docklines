FROM wordpress:php7.2-fpm

LABEL Thoriq Firdaus <thoriqoe@gmail.com>

# Install extra packages
RUN set -ex; \
	apt-get update \
	&& EXTRA_PACKAGES=" \
		mysql-client \
		unzip \
		subversion \
		git \
		ssh \
	" \
	&& apt-get install -y $EXTRA_PACKAGES --no-install-recommends \
	&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/*

# Install WP-CLI
ENV WP_CLI_VERSION 2.0.0
ENV WP_CLI_SHA512 18c15c792a0747e434f70fb74f8d82dbc6dc504bd6238a4928859430129f12d88d829a1f37203c30813eb5f4d2c69f4e40aa15c74d9c6f01343052f01842463b

RUN set -ex; \
	curl -o /usr/local/bin/wp.phar -fSL "https://github.com/wp-cli/wp-cli/releases/download/v${WP_CLI_VERSION}/wp-cli-${WP_CLI_VERSION}.phar" \
	&& echo "$WP_CLI_SHA512 */usr/local/bin/wp.phar" | sha512sum -c - \
	&& chmod +x /usr/local/bin/wp.phar \
	&& mv /usr/local/bin/wp.phar /usr/local/bin/wp \
	&& mkdir -p /var/www/.wp-cli && chown www-data:www-data -R /var/www/.wp-cli \
	&& wp cli info

# Install PHPUnit
# SHA256 source: https://phar.phpunit.de/
ENV PHPUNIT_VERSION 6.5.9
ENV PHPUNIT_SHA256 047523dfd3fdc75d8f4b97e9d31679d091045a47a1b41e454df8fa840baba334

RUN set -ex; \
	curl -o /usr/local/bin/phpunit.phar -fSL "https://phar.phpunit.de/phpunit-${PHPUNIT_VERSION}.phar" \
	&& echo "$PHPUNIT_SHA256 */usr/local/bin/phpunit.phar" | sha256sum -c - \
	&& chmod +x /usr/local/bin/phpunit.phar \
	&& mv /usr/local/bin/phpunit.phar /usr/local/bin/phpunit \
	&& phpunit --version

# Install PHP CodeSniffer && WordPress Coding Standards
# SHA256 source: https://squizlabs.github.io/PHP_CodeSniffer/phars/phive.xml
ENV PHPCS_VERSION 3.3.0
ENV PHPCS_SHA256 90442ce92ffccfad906f411919d26be54005064463707ea4beba3684d92e83fe

ENV PHPCBF_VERSION $PHPCS_VERSION
ENV PHPCBF_SHA256 9a9e93310a4e9de509aa06648e69fc91b8141661abb818aeb421e4fa5f3100aa

ENV WPCS_VERSION 1.0.0

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
