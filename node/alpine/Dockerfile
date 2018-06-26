FROM node:8-alpine

LABEL Thoriq Firdaus <thoriqoe@gmail.com>

# Ensure the www-data user exists.
RUN set -x ; \
	addgroup -g 82 -S www-data ; \
	adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1

RUN set -ex; \
	mkdir -p /var/www/ \
	&& chown www-data:www-data -R /var/www/

RUN set -ex; \
	npm i npm@latest -g \
	npm install --global ---verbose \
		http-server \
		gulp-cli \
		grunt-cli \
		eslint \
		stylelint \
	&& node --version \
	&& npm --version \
	&& gulp --version \
	&& grunt --version \
	&& eslint --version \
	&& stylelint --version
