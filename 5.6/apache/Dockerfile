FROM wordpress:php5.6-apache

MAINTAINER Thoriq Firdaus <thoriqoe@gmail.com>

# Utility
RUN apt-get update \
	&& apt-get install -y openssl git subversion wget ssh --no-install-recommends

# SSL Cert
RUN apt-get update \
	&& apt-get install -y --no-install-recommends ssl-cert \
	&& a2enmod ssl \
	&& a2ensite default-ssl

# Install composer and put binary into $PATH
RUN curl -sS https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/ \
	&& ln -s /usr/local/bin/composer.phar /usr/local/bin/composer

# Install PHPUnit
RUN curl -OL https://phar.phpunit.de/phpunit-5.7.phar \
	&& chmod 755 phpunit-5.7.phar \
	&& mv phpunit-5.7.phar /usr/local/bin/ \
	&& ln -s /usr/local/bin/phpunit-5.7.phar /usr/local/bin/phpunit \
	&& phpunit --version

# Install PHP Code sniffer.
RUN curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar \
	&& chmod 755 phpcs.phar \
	&& mv phpcs.phar /usr/local/bin/ \
	&& ln -s /usr/local/bin/phpcs.phar /usr/local/bin/phpcs \
	&& curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar \
	&& chmod 755 phpcbf.phar \
	&& mv phpcbf.phar /usr/local/bin/ \
	&& ln -s /usr/local/bin/phpcbf.phar /usr/local/bin/phpcbf

# Install WordPress Code Standard.
RUN git clone -b master https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards.git /var/wpcs \
	&& phpcs --config-set show_progress 1 \
	&& phpcs --config-set colors 1 \
	&& phpcs --config-set installed_paths /var/wpcs

# Install WP-CLI
RUN curl --insecure -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

## NodeJS, NPM
# Install NodeJS
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - \
	&& apt-get install -y nodejs

# Clean
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/*

# Suppress Could not reliably determine the server's fully qualified domain name, using 172.17.0.2.
RUN echo "ServerName localhost" > /etc/apache2/conf-available/servername.conf && \
	ln -s /etc/apache2/conf-available/servername.conf /etc/apache2/conf-enabled/servername.conf

EXPOSE 80 443
