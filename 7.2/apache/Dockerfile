FROM wordpress:php7.2-apache

MAINTAINER Thoriq Firdaus <thoriqoe@gmail.com>

# Install extra packages
RUN apt-get update && apt-get install -y subversion git unzip ssh gnupg mysql-client --no-install-recommends

## Install WP-CLI
RUN curl -OL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp \
	&& wp --version --allow-root

## Install composer and put binary into $PATH
RUN curl -sS https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/ \
	&& ln -s /usr/local/bin/composer.phar /usr/local/bin/composer \
	&& composer --version

## INstall PHPUnit
RUN curl -OL https://phar.phpunit.de/phpunit-5.7.phar \
	&& chmod 755 phpunit-5.7.phar \
	&& mv phpunit-5.7.phar /usr/local/bin/ \
	&& ln -s /usr/local/bin/phpunit-5.7.phar /usr/local/bin/phpunit \
	&& phpunit --version

# Install PHP CodeSniffer
RUN	curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar \
	&& chmod 755 phpcs.phar \
	&& mv phpcs.phar /usr/local/bin/ \
	&& ln -s /usr/local/bin/phpcs.phar /usr/local/bin/phpcs \
	&& phpcs --version

# Install PHPCBF
RUN	curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar \
	&& chmod 755 phpcbf.phar \
	&& mv phpcbf.phar /usr/local/bin/ \
	&& ln -s /usr/local/bin/phpcbf.phar /usr/local/bin/phpcbf

## Install WordPress Coding Standards
RUN curl -OL https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards/archive/0.14.0.tar.gz \
	&& mkdir -p /var/wpcs \
	&& tar -xzf 0.14.0.tar.gz --directory /var/wpcs --strip-components 1 \
	&& rm 0.14.0.tar.gz \
	&& phpcs --config-set show_progress 1 \
	&& phpcs --config-set colors 1 \
	&& phpcs --config-set installed_paths /var/wpcs

# Install NodeJS && NPM
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
	&& apt-get install -y nodejs \
	&& nodejs --version

# Add a wp-docklines-entrypoint.sh
COPY wp-docklines-entrypoint.sh /usr/local/bin/

# Misc.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/* \
	&& echo "ServerName localhost" > /etc/apache2/conf-available/servername.conf \
	&& ln -s /etc/apache2/conf-available/servername.conf /etc/apache2/conf-enabled/servername.conf \
	&& chmod +x /usr/local/bin/wp-docklines-entrypoint.sh

ENTRYPOINT ["wp-docklines-entrypoint.sh"]
CMD ["apache2-foreground"]
