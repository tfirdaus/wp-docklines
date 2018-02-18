FROM wordpress:php7.2-fpm-alpine

MAINTAINER Thoriq Firdaus <thoriqoe@gmail.com>

# Install extra packages
RUN set -ex; \
	apk add --update --no-cache mysql-client openssh-client unzip subversion git

# Install WP-CLI
# pub   2048R/2F6B6B7F 2016-01-07
#       Key fingerprint = 3B91 9162 5F3B 1F1B F5DD  3B47 673A 0204 2F6B 6B7F
# uid                  Daniel Bachhuber <daniel@handbuilt.co>
# sub   2048R/45F9CDE2 2016-01-07
ENV WP_CLI_VERSION 1.5.0
ENV WP_CLI_GPG_KEY 3B9191625F3B1F1BF5DD3B47673A02042F6B6B7F
ENV WP_CLI_SHA512 9385c63ab835c7c450529035cdb1f524b5878a67c7565c3497628e5ec4ec07ae4a34ef25c59a9e7d6edea7cdb039fcef7a1f731b922782b8c70418480bdff122

RUN set -ex; \
	apk add --no-cache --virtual .build-deps \
		gnupg \
	&& curl -o /usr/local/bin/wp.gpg -fSL "https://github.com/wp-cli/wp-cli/releases/download/v${WP_CLI_VERSION}/wp-cli-${WP_CLI_VERSION}.phar.gpg" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver pgp.mit.edu --recv-keys "$WP_CLI_GPG_KEY" \
	&& gpg --batch --decrypt --output /usr/local/bin/wp /usr/local/bin/wp.gpg \
	&& rm -rf "$GNUPGHOME" /usr/local/bin/wp.gpg \
	&& echo "$WP_CLI_SHA512 */usr/local/bin/wp" | sha512sum -c - \
	&& chmod +x /usr/local/bin/wp \
	&& apk del .build-deps \
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
ENV PHPUNIT_VERSION 6.5.6
ENV PHPUNIT_GPG_KEY D8406D0D82947747293778314AA394086372C20A
ENV PHPUNIT_SHA256 ad0d5f8dfbd95ffcbfbe7fde4fa7a9d4f24fa6e070b1215faea579cdefac08f3

RUN set -ex; \
	apk add --no-cache --virtual .build-deps \
		gnupg \
	&& curl -o /usr/local/bin/phpunit.phar -fSL "https://phar.phpunit.de/phpunit-${PHPUNIT_VERSION}.phar" \
	&& curl -o /usr/local/bin/phpunit.phar.asc -fSL "https://phar.phpunit.de/phpunit-${PHPUNIT_VERSION}.phar.asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver pgp.uni-mainz.de --recv-keys "$PHPUNIT_GPG_KEY" \
	&& gpg --batch --verify /usr/local/bin/phpunit.phar.asc /usr/local/bin/phpunit.phar \
	&& rm -rf "$GNUPGHOME" /usr/local/bin/phpunit.phar.asc \
	&& echo "$PHPUNIT_SHA256 */usr/local/bin/phpunit.phar" | sha256sum -c - \
	&& chmod +x /usr/local/bin/phpunit.phar \
	&& mv /usr/local/bin/phpunit.phar /usr/local/bin/phpunit \
	&& apk del .build-deps \
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
	apk add --no-cache --virtual .build-deps \
		gnupg \
	&& curl -o /usr/local/bin/phpcs.phar -fSL "https://github.com/squizlabs/PHP_CodeSniffer/releases/download/${PHPCS_VERSION}/phpcs.phar" \
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
	&& apk del .build-deps \
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
	apk add --no-cache \
        libstdc++ \
    && apk add --no-cache --virtual .build-deps \
        binutils-gold \
        g++ \
        gcc \
        gnupg \
        libgcc \
        linux-headers \
        make \
        python \
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
    && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION.tar.xz" \
    && curl -SLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
    && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
    && grep " node-v$NODE_VERSION.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
    && tar -xf "node-v$NODE_VERSION.tar.xz" \
    && cd "node-v$NODE_VERSION" \
    && ./configure \
    && make -j$(getconf _NPROCESSORS_ONLN) \
    && make install \
    && apk del .build-deps \
    && cd .. \
    && rm -Rf "node-v$NODE_VERSION" \
    && rm "node-v$NODE_VERSION.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt \
	&& node --version \
	&& npm --version
