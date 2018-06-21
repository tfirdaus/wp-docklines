FROM node:8-alpine

LABEL Thoriq Firdaus <thoriqoe@gmail.com>

RUN set -ex; \
	npm install --global \
		http-server \
		gulp-cli \
		grunt-cli \
		eslint \
		stylelint \
	&& gulp --version \
	&& grunt --version \
	&& eslint --version \
	&& stylelint --version

EXPOSE 3000
CMD ["http-server -p 3000"]
