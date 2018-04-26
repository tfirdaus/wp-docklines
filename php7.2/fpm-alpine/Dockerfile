FROM wordpress:php7.2-fpm-alpine

LABEL Thoriq Firdaus <thoriqoe@gmail.com>

# Install extra packages
RUN set -ex; \
	apk add --update --no-cache mysql-client unzip subversion git

# Install WP-CLI
ENV WP_CLI_VERSION 1.5.1
ENV WP_CLI_SHA512 8693cdbc06cca37be9976c4f76aa81c111095f88bb121277cbdfa85f8a2ada3b9133cd9641c439e6f5579d3469a1a44488e872ecbff3d3eba0488bbc8033d6d8

RUN set -ex; \
	curl -o /usr/local/bin/wp.phar -fSL "https://github.com/wp-cli/wp-cli/releases/download/v${WP_CLI_VERSION}/wp-cli-${WP_CLI_VERSION}.phar" \
	&& echo "$WP_CLI_SHA512 */usr/local/bin/wp.phar" | sha512sum -c - \
	&& chmod +x /usr/local/bin/wp.phar \
	&& mv /usr/local/bin/wp.phar /usr/local/bin/wp \
	&& mkdir -p /var/www/.wp-cli && chown www-data:www-data -R /var/www/.wp-cli \
	&& wp cli info

# Install PHPUnit
# SHA256 source: https://phar.phpunit.de/
ENV PHPUNIT_VERSION 6.5.8
ENV PHPUNIT_SHA256 ff911ab2d6900efe65b25c404a83bc8a74fe6f443606d170dc05738f887b2238

RUN set -ex; \
	curl -o /usr/local/bin/phpunit.phar -fSL "https://phar.phpunit.de/phpunit-${PHPUNIT_VERSION}.phar" \
	&& echo "$PHPUNIT_SHA256 */usr/local/bin/phpunit.phar" | sha256sum -c - \
	&& chmod +x /usr/local/bin/phpunit.phar \
	&& mv /usr/local/bin/phpunit.phar /usr/local/bin/phpunit \
	&& phpunit --version

# Install PHP CodeSniffer && WordPress Coding Standards
# SHA256 source: https://squizlabs.github.io/PHP_CodeSniffer/phars/phive.xml
ENV PHPCS_VERSION 3.2.3
ENV PHPCS_SHA256 41ef9d09fca6be1dce5ee6b946a59461f4955245c3038c0ac17e0669caef6aa4

ENV PHPCBF_VERSION $PHPCS_VERSION
ENV PHPCBF_SHA256 34a94620615b674ef4ed44ab1648a9f1c874b35b4d48239e81a177a803a0e002

ENV WPCS_VERSION 0.14.1

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
