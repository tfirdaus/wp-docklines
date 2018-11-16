FROM node:jessie

LABEL Thoriq Firdaus <thoriqoe@gmail.com>

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
	&& yarn --version \
	&& gulp --version \
	&& grunt --version \
	&& eslint --version \
	&& stylelint --version
