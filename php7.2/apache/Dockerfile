FROM wordpress:php7.2-apache

MAINTAINER Thoriq Firdaus <thoriqoe@gmail.com>

ENV PHPUNIT_VERSION 6.5.5
ENV PHPCS_VERSION 3.1.1
ENV WPCS_VERSION 0.14.0
ENV NODE_VERSION 8.9.4

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

## Install WP-CLI
RUN set -ex; \
	curl -OL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

## Install PHPUnit
RUN set -ex; \
	curl -o phpunit.phar -fSL "https://phar.phpunit.de/phpunit-${PHPUNIT_VERSION}.phar" \
	&& chmod 755 phpunit.phar \
	&& mv phpunit.phar /usr/local/bin/ \
	&& ln -s /usr/local/bin/phpunit.phar /usr/local/bin/phpunit

# Install PHP CodeSniffer && WordPress Coding Standards
RUN set -ex; \
	curl -OL "https://github.com/squizlabs/PHP_CodeSniffer/releases/download/${PHPCS_VERSION}/phpcs.phar" \
	&& chmod 755 phpcs.phar \
	&& mv phpcs.phar /usr/local/bin/ \
	&& ln -s /usr/local/bin/phpcs.phar /usr/local/bin/phpcs \
    && curl -OL "https://github.com/squizlabs/PHP_CodeSniffer/releases/download/${PHPCS_VERSION}/phpcbf.phar" \
	&& chmod 755 phpcbf.phar \
	&& mv phpcbf.phar /usr/local/bin/ \
	&& ln -s /usr/local/bin/phpcbf.phar /usr/local/bin/phpcbf \
	&& curl -o wpcs.tar.gz -fSL "https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards/archive/${WPCS_VERSION}.tar.gz" \
	&& mkdir -p /var/wpcs \
	&& tar -xzf wpcs.tar.gz --directory /var/wpcs --strip-components 1 && rm wpcs.tar.gz \
	&& phpcs --config-set show_progress 1 \
	&& phpcs --config-set colors 1 \
	&& phpcs --config-set installed_paths /var/wpcs

# Install NodeJS && NPM
RUN set -ex \
	&& BUILD_PACKAGES=" \
		gnupg \
		dirmngr \
	" \
	&& apt-get update && apt-get install -y $BUILD_PACKAGES --no-install-recommends \
	&& for key in \
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
	&& apt-get remove --purge -y $BUILD_PACKAGES \
	&& apt-get autoremove -y \
	&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/*

##<apache>##
RUN set -ex; \
	echo "ServerName localhost" > /etc/apache2/conf-available/servername.conf \
	&& ln -s /etc/apache2/conf-available/servername.conf /etc/apache2/conf-enabled/servername.conf
##</apache>##
