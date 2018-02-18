FROM php:5.5-fpm

MAINTAINER Thoriq Firdaus <thoriqoe@gmail.com>

# install the PHP extensions we need
RUN set -ex; \
	\
	apt-get update; \
	apt-get install -y \
		libjpeg-dev \
		libpng-dev \
	; \
	rm -rf /var/lib/apt/lists/*; \
	\
	docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
	docker-php-ext-install gd mysqli opcache
# TODO consider removing the *-dev deps and only keeping the necessary lib* packages

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

RUN set -ex; \
	curl -o wordpress.tar.gz -fSL "https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz"; \
	echo "$WORDPRESS_SHA1 *wordpress.tar.gz" | sha1sum -c -; \
# upstream tarballs include ./wordpress/ so this gives us /usr/src/wordpress
	tar -xzf wordpress.tar.gz -C /usr/src/; \
	rm wordpress.tar.gz; \
	chown -R www-data:www-data /usr/src/wordpress


##<wp-docklines>##
# Install extra packages
RUN set -ex; \
	apt-get update \
	&& EXTRA_PACKAGES=" \
		mysql-client \
		ssh \
		unzip \
		subversion \
		git \
	" \
	&& apt-get install -y $EXTRA_PACKAGES --no-install-recommends \
	&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/*

# Install WP-CLI
# pub   2048R/2F6B6B7F 2016-01-07
#       Key fingerprint = 3B91 9162 5F3B 1F1B F5DD  3B47 673A 0204 2F6B 6B7F
# uid                  Daniel Bachhuber <daniel@handbuilt.co>
# sub   2048R/45F9CDE2 2016-01-07
ENV WP_CLI_VERSION 1.5.0
ENV WP_CLI_GPG_KEY 3B9191625F3B1F1BF5DD3B47673A02042F6B6B7F
ENV WP_CLI_SHA512 9385c63ab835c7c450529035cdb1f524b5878a67c7565c3497628e5ec4ec07ae4a34ef25c59a9e7d6edea7cdb039fcef7a1f731b922782b8c70418480bdff122

RUN set -ex; \
	curl -o /usr/local/bin/wp.gpg -fSL "https://github.com/wp-cli/wp-cli/releases/download/v${WP_CLI_VERSION}/wp-cli-${WP_CLI_VERSION}.phar.gpg" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver pgp.mit.edu --recv-keys "$WP_CLI_GPG_KEY" \
	&& gpg --batch --decrypt --output /usr/local/bin/wp /usr/local/bin/wp.gpg \
	&& rm -rf "$GNUPGHOME" /usr/local/bin/wp.gpg \
	&& echo "$WP_CLI_SHA512 */usr/local/bin/wp" | sha512sum -c - \
	&& chmod +x /usr/local/bin/wp \
	&& mkdir -p /var/www/.wp-cli && chown www-data:www-data -R /var/www/.wp-cli \
	&& wp cli info

# Install PHPUnit
# SHA256 source: https://phar.phpunit.de/
# Signature made Sat 19 Jul 2014 01:28:02 PM CEST using RSA key ID 6372C20A
# Good signature from "Sebastian Bergmann <sb@sebastian-bergmann.de>"
#                 aka "Sebastian Bergmann <sebastian@php.net>"
#                 aka "Sebastian Bergmann <sebastian@thephp.cc>"
#                 aka "Sebastian Bergmann <sebastian@phpunit.de>"
#                 aka "Sebastian Bergmann <sebastian.bergmann@thephp.cc>"
#                 aka "[jpeg image of size 40635]"
# Primary key fingerprint: D840 6D0D 8294 7747 2937  7831 4AA3 9408 6372 C20A
ENV PHPUNIT_VERSION 4.8.36
ENV PHPUNIT_GPG_KEY D8406D0D82947747293778314AA394086372C20A
ENV PHPUNIT_SHA256 ab8bc3017a64cf75a2112f5e089a1d5b0c4cc2116556d60c1af5e3f584e85c5e

RUN set -ex; \
	curl -o /usr/local/bin/phpunit.phar -fSL "https://phar.phpunit.de/phpunit-${PHPUNIT_VERSION}.phar" \
	&& curl -o /usr/local/bin/phpunit.phar.asc -fSL "https://phar.phpunit.de/phpunit-${PHPUNIT_VERSION}.phar.asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver pgp.uni-mainz.de --recv-keys "$PHPUNIT_GPG_KEY" \
	&& gpg --batch --verify /usr/local/bin/phpunit.phar.asc /usr/local/bin/phpunit.phar \
	&& rm -rf "$GNUPGHOME" /usr/local/bin/phpunit.phar.asc \
	&& echo "$PHPUNIT_SHA256 */usr/local/bin/phpunit.phar" | sha256sum -c - \
	&& chmod +x /usr/local/bin/phpunit.phar \
	&& mv /usr/local/bin/phpunit.phar /usr/local/bin/phpunit \
	&& phpunit --version

# Install PHP CodeSniffer && WordPress Coding Standards
# SHA256 source: https://squizlabs.github.io/PHP_CodeSniffer/phars/phive.xml
# Signature made Tue Dec 19 21:59:03 2017 UTC using RSA key ID E2138192
# Good signature from "Greg Sherwood <gsherwood@squiz.net>"
# Primary key fingerprint: A972 B9AB B95D 0B76 0B51  4422 31C7 E470 E213 8192
ENV PHPCS_VERSION 3.2.2
ENV PHPCS_GPG_KEY A972B9ABB95D0B760B51442231C7E470E2138192
ENV PHPCS_SHA256 c934737207f3baf2d36187a43ed4bd005a70eae65f16cf22ca4eed32a69aca2a

ENV PHPCBF_VERSION $PHPCS_VERSION
ENV PHPCBF_GPG_KEY $PHPCS_GPG_KEY
ENV PHPCBF_SHA256 7ad5e782411f4b8944a0bfab7d70b782c3133c921fd237b8227567186ef71f52

ENV WPCS_VERSION 0.14.1

RUN set -ex; \
	curl -o /usr/local/bin/phpcs.phar -fSL "https://github.com/squizlabs/PHP_CodeSniffer/releases/download/${PHPCS_VERSION}/phpcs.phar" \
	&& curl -o /usr/local/bin/phpcs.phar.asc -fSL "https://github.com/squizlabs/PHP_CodeSniffer/releases/download/${PHPCS_VERSION}/phpcs.phar.asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$PHPCS_GPG_KEY" \
	&& gpg --batch --verify /usr/local/bin/phpcs.phar.asc /usr/local/bin/phpcs.phar \
	&& rm -rf "$GNUPGHOME" /usr/local/bin/phpcs.phar.asc \
	&& echo "$PHPCS_SHA256 */usr/local/bin/phpcs.phar" | sha256sum -c - \
	&& chmod +x /usr/local/bin/phpcs.phar \
	&& mv /usr/local/bin/phpcs.phar /usr/local/bin/phpcs \
    && curl -o /usr/local/bin/phpcbf.phar -fSL "https://github.com/squizlabs/PHP_CodeSniffer/releases/download/${PHPCBF_VERSION}/phpcbf.phar" \
	&& curl -o /usr/local/bin/phpcbf.phar.asc -fSL "https://github.com/squizlabs/PHP_CodeSniffer/releases/download/${PHPCBF_VERSION}/phpcbf.phar.asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$PHPCBF_GPG_KEY" \
	&& gpg --batch --verify /usr/local/bin/phpcbf.phar.asc /usr/local/bin/phpcbf.phar \
	&& rm -rf "$GNUPGHOME" /usr/local/bin/phpcbf.phar.asc \
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

# Install NodeJS && NPM
# Node GPG Keys https://github.com/nodejs/node#release-team
ENV NODE_VERSION 8.9.4

RUN set -ex; \
	for key in \
	    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
	    FD3A5288F042B6850C66B31F09FE44734EB7990E \
	    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
	    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
	    C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
	    B9AE9905FFD7803F25714661B63B535A4C206CA9 \
	    56730D5401028683275BD23C23EFEFE93C4CFFFE \
	    77984A986EBC2AA786BC0F66B01FBB92821C587A \
  	; do \
    gpg --keyserver pgp.mit.edu --recv-keys "$key" || \
    gpg --keyserver keyserver.pgp.com --recv-keys "$key" || \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" ; \
  	done \
	&& ARCH= && dpkgArch="$(dpkg --print-architecture)" \
	&& case "${dpkgArch##*-}" in \
		amd64) ARCH='x64';; \
		ppc64el) ARCH='ppc64le';; \
		s390x) ARCH='s390x';; \
		arm64) ARCH='arm64';; \
		armhf) ARCH='armv7l';; \
		i386) ARCH='x86';; \
	    *) echo "unsupported architecture"; exit 1 ;; \
		esac \
	&& curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-$ARCH.tar.xz" \
	&& curl -SLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
	&& gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
	&& grep " node-v$NODE_VERSION-linux-$ARCH.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
	&& tar -xJf "node-v$NODE_VERSION-linux-$ARCH.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
	&& rm "node-v$NODE_VERSION-linux-$ARCH.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt \
	&& ln -s /usr/local/bin/node /usr/local/bin/nodejs \
	&& node --version \
	&& npm --version
##</wp-docklines>##

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
