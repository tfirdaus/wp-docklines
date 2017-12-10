FROM wordpress:php7.1-fpm

MAINTAINER Thoriq Firdaus <thoriqoe@gmail.com>

# Install Utility
RUN apt-get update && apt-get install -y git subversion wget ssh gnupg --no-install-recommends \

	## Install composer and put binary into $PATH
	&& curl -sS https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/ \
	&& ln -s /usr/local/bin/composer.phar /usr/local/bin/composer \

	## Install WP-CLI
	&& curl --insecure -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Install PHPUnit
RUN curl -OL https://phar.phpunit.de/phpunit-5.7.phar \
	&& chmod 755 phpunit-5.7.phar \
	&& mv phpunit-5.7.phar /usr/local/bin/ \
	&& ln -s /usr/local/bin/phpunit-5.7.phar /usr/local/bin/phpunit \
	&& phpunit --version \

	# Install PHP CodeSniffer
	&& curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar \
	&& chmod 755 phpcs.phar \
	&& mv phpcs.phar /usr/local/bin/ \
	&& ln -s /usr/local/bin/phpcs.phar /usr/local/bin/phpcs \
	&& curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar \
	&& chmod 755 phpcbf.phar \
	&& mv phpcbf.phar /usr/local/bin/ \
	&& ln -s /usr/local/bin/phpcbf.phar /usr/local/bin/phpcbf \

	## Install WordPress Coding Standards
	&& git clone -b master https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards.git /var/wpcs \
	&& phpcs --config-set show_progress 1 \
	&& phpcs --config-set colors 1 \
	&& phpcs --config-set installed_paths /var/wpcs

# Install NodeJS && NPM
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
	&& apt-get install -y nodejs

# Add a wp-docklines-entrypoint.sh
COPY wp-docklines-entrypoint.sh /usr/local/bin/

# Misc.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/* \

	## Make the wp-docklines-entrypoint.sh executable.
	&& chmod +x /usr/local/bin/wp-docklines-entrypoint.sh

ENTRYPOINT ["wp-docklines-entrypoint.sh"]
CMD ["php-fpm"]
