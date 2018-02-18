# WP-Docklines

[![Travis](https://img.shields.io/travis/tfirdaus/wp-docklines.svg?style=for-the-badge)](https://travis-ci.org/tfirdaus/wp-docklines) [![Docker Pulls](https://img.shields.io/docker/pulls/tfirdaus/wp-docklines.svg?style=for-the-badge)](https://hub.docker.com/r/tfirdaus/wp-docklines/) [![license](https://img.shields.io/github/license/tfirdaus/wp-docklines.svg?style=for-the-badge)](https://github.com/tfirdaus/wp-docklines)

A WordPress [Docker](https://www.docker.com/) image derivative for setting up a local environment to develop WordPress plugins or themes locally in your computer and to perform CI (Continuous Integration) or CD (Continuous Delivery) in services like [Bitbucket Pipelines](https://bitbucket.org/product/features/pipelines). Each of these Docker images includes:

- [WordPress](https://wordpress.org/download/).
- [WP-CLI](http://wp-cli.org/)
- [PHPUnit](https://phpunit.de/)
- [PHPCS](https://github.com/squizlabs/PHP_CodeSniffer) with [WordPress Coding Standards](https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards)
- [Node.js](https://nodejs.org/en/)
- [Subversion](https://subversion.apache.org/)
- [Git](https://git-scm.com/)

See the following table for version of each package included :

| Image | WP-CLI | PHPUnit | PHPCS | WPCS | Node.js | NPM | SVN | Git |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `php5.4-apache`     | 1.5.0 | 4.8.36 | 3.2.2 | 0.14.0 | 8.9.4 | 5.6.0 | 1.8.10 | 2.1.4  |
| `php5.4-fpm`        | 1.5.0 | 4.8.36 | 3.2.2 | 0.14.0 | 8.9.4 | 5.6.0 | 1.8.10 | 2.1.4  |
| `php5.5-apache`     | 1.5.0 | 4.8.36 | 3.2.2 | 0.14.0 | 8.9.4 | 5.6.0 | 1.8.10 | 2.1.4  |
| `php5.5-fpm`        | 1.5.0 | 4.8.36 | 3.2.2 | 0.14.0 | 8.9.4 | 5.6.0 | 1.8.10 | 2.1.4  |
| `php5.5-fpm-alpine` | 1.5.0 | 4.8.36 | 3.2.2 | 0.14.0 | 8.9.4 | 5.6.0 | 1.9.7  | 2.8.6  |
| `php5.6-apache`     | 1.5.0 | 5.7.27 | 3.2.2 | 0.14.0 | 8.9.4 | 5.6.0 | 1.8.10 | 2.1.4  |
| `php5.6-fpm`        | 1.5.0 | 5.7.27 | 3.2.2 | 0.14.0 | 8.9.4 | 5.6.0 | 1.8.10 | 2.1.4  |
| `php5.6-fpm-alpine` | 1.5.0 | 5.7.27 | 3.2.2 | 0.14.0 | 8.9.4 | 5.6.0 | 1.9.7  | 2.8.6  |
| `php7.0-apache`     | 1.5.0 | 6.5.6  | 3.2.2 | 0.14.0 | 8.9.4 | 5.6.0 | 1.8.10 | 2.1.4  |
| `php7.0-fpm`        | 1.5.0 | 6.5.6  | 3.2.2 | 0.14.0 | 8.9.4 | 5.6.0 | 1.8.10 | 2.1.4  |
| `php7.0-fpm-alpine` | 1.5.0 | 6.5.6  | 3.2.2 | 0.14.0 | 8.9.4 | 5.6.0 | 1.9.7  | 2.8.6  |
| `php7.1-apache`     | 1.5.0 | 7.0.1  | 3.2.2 | 0.14.0 | 8.9.4 | 5.6.0 | 1.8.10 | 2.1.4  |
| `php7.1-fpm`        | 1.5.0 | 7.0.1  | 3.2.2 | 0.14.0 | 8.9.4 | 5.6.0 | 1.8.10 | 2.1.4  |
| `php7.1-fpm-alpine` | 1.5.0 | 7.0.1  | 3.2.2 | 0.14.0 | 8.9.4 | 5.6.0 | 1.9.7  | 2.8.6  |
| `php7.2-apache`     | 1.5.0 | 7.0.1  | 3.2.2 | 0.14.0 | 8.9.4 | 5.6.0 | 1.9.5  | 2.11.0 |
| `php7.2-fpm`        | 1.5.0 | 7.0.1  | 3.2.2 | 0.14.0 | 8.9.4 | 5.6.0 | 1.9.5  | 2.11.0 |
| `php7.2-fpm-alpine` | 1.5.0 | 7.0.1  | 3.2.2 | 0.14.0 | 8.9.4 | 5.6.0 | 1.9.7  | 2.13.5 |

## Usage
If you'd like to use it on your computer, you'll need to install Docker ([Mac](https://www.docker.com/docker-mac)|[Windows](https://www.docker.com/docker-windows)). The image is available in [Docker Hub](https://hub.docker.com/). Run `docker pull tfirdaus/wp-docklines` command to pull the latest image which defaults to the `latest` tag or `php7.2-apache`. Have a look at the [Wiki](https://github.com/tfirdaus/wp-docklines/wiki) for a few usages:

- [Docker Compose](https://github.com/tfirdaus/wp-docklines/wiki/Docker-Compose)
- Bitbucket Pipelines (soon)

## PHP Libraries / Extensions
Following the image origin at [WordPress Official Docker image](https://hub.docker.com/_/wordpress/), this image does not provide any additional PHP extensions or other libraries as well. There is an infinite number of possible plugins and including every PHP extension that exists would dramatically increase the image size.
