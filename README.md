# WP Docklines

[![Docker Automated build](https://img.shields.io/docker/automated/tfirdaus/wp-docklines.svg?style=flat)](https://hub.docker.com/r/tfirdaus/wp-docklines/) [![Docker Pulls](https://img.shields.io/docker/pulls/tfirdaus/wp-docklines.svg?style=flat)](https://hub.docker.com/r/tfirdaus/wp-docklines/) [![Docker Build Status](https://img.shields.io/docker/build/tfirdaus/wp-docklines.svg?style=flat)](https://hub.docker.com/r/tfirdaus/wp-docklines/) [![Travis](https://img.shields.io/travis/tfirdaus/wp-docklines.svg?style=flat)](https://travis-ci.org/tfirdaus/wp-docklines) [![License](https://img.shields.io/github/license/tfirdaus/wp-docklines.svg?style=flat)](https://github.com/tfirdaus/wp-docklines)

> [Docker](https://www.docker.com/) images for setting up and running a WordPress development environment.

Each of these Docker images include:

- [WordPress](https://wordpress.org/download/)
- [WP-CLI](http://wp-cli.org/)
- [PHPUnit](https://phpunit.de/)
- [PHPCS](https://github.com/squizlabs/PHP_CodeSniffer) with [WordPress Coding Standards](https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards)
- [Subversion](https://subversion.apache.org/)
- [Git](https://git-scm.com/)

See the following table for version of each package included:

## PHP Images

| Image | WP-CLI | PHPUnit | PHPCS | WPCS | SVN | Git |
| --- | --- | --- | --- | --- | --- | --- |
| `php5.4-apache`     | 2.0.1 | 4.8.36 | 3.3.2 | 1.2.0 | 1.8.10 | 2.1.4  |
| `php5.4-fpm`        | 2.0.1 | 4.8.36 | 3.3.2 | 1.2.0 | 1.8.10 | 2.1.4  |
| `php5.5-apache`     | 2.0.1 | 4.8.36 | 3.3.2 | 1.2.0 | 1.8.10 | 2.1.4  |
| `php5.5-fpm`        | 2.0.1 | 4.8.36 | 3.3.2 | 1.2.0 | 1.8.10 | 2.1.4  |
| `php5.5-fpm-alpine` | 2.0.1 | 4.8.36 | 3.3.2 | 1.2.0 | 1.9.7  | 2.8.6  |
| `php5.6-apache`     | 2.0.1 | 5.7.27 | 3.3.2 | 1.2.0 | 1.9.5  | 2.11.0 |
| `php5.6-fpm`        | 2.0.1 | 5.7.27 | 3.3.2 | 1.2.0 | 1.9.5  | 2.11.0 |
| `php5.6-fpm-alpine` | 2.0.1 | 5.7.27 | 3.3.2 | 1.2.0 | 1.10.0 | 2.18.1 |
| `php7.0-apache`     | 2.0.1 | 6.5.13 | 3.3.2 | 1.2.0 | 1.9.5  | 2.11.0 |
| `php7.0-fpm`        | 2.0.1 | 6.5.13 | 3.3.2 | 1.2.0 | 1.9.5  | 2.11.0 |
| `php7.0-fpm-alpine` | 2.0.1 | 6.5.13 | 3.3.2 | 1.2.0 | 1.9.7  | 2.15.3 |
| `php7.1-apache`     | 2.0.1 | 6.5.13 | 3.3.2 | 1.2.0 | 1.9.5  | 2.11.0 |
| `php7.1-fpm`        | 2.0.1 | 6.5.13 | 3.3.2 | 1.2.0 | 1.9.5  | 2.11.0 |
| `php7.1-fpm-alpine` | 2.0.1 | 6.5.13 | 3.3.2 | 1.2.0 | 1.10.0 | 2.18.1 |
| `php7.2-apache`     | 2.0.1 | 6.5.13 | 3.3.2 | 1.2.0 | 1.9.5  | 2.11.0 |
| `php7.2-fpm`        | 2.0.1 | 6.5.13 | 3.3.2 | 1.2.0 | 1.9.5  | 2.11.0 |
| `php7.2-fpm-alpine` | 2.0.1 | 6.5.13 | 3.3.2 | 1.2.0 | 1.10.0 | 2.18.1 |

## Node Images

| Image | Node | NPM | Yarn | Gulp CLI | Grunt CLI | ESLint | Stylelint |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `jessie`  | 10.13.0 | 6.4.1 | 1.10.1 | 2.0.1 | 1.3.2 | 5.9.0 | 9.8.0 |
| `alpine`  | 10.13.0 | 6.4.1 | 1.10.1 | 2.0.1 | 1.3.2 | 5.9.0 | 9.8.0 |

## PHP Libraries / Extensions

The image also includes the following packages that might be needed for deployment or running a few select WP-CLI commands that require interaction with the `mysql` command such as `wp db import` and `wp db export`:

- `mysql-client`
- `unzip`
- `ssh-client`

## Usage

You'll need to install Docker ([Mac](https://www.docker.com/docker-mac)|[Windows](https://www.docker.com/docker-windows)) on your machine. The image is available in [Docker Hub](https://hub.docker.com/), and you can run `docker pull tfirdaus/wp-docklines` command to pull the latest image which defaults to the `latest` tag or `php7.2-apache`. Have a look at the [Wiki](https://github.com/tfirdaus/wp-docklines/wiki) for a few real-world usages of these images:

- [Docker Compose](https://github.com/tfirdaus/wp-docklines/wiki/Docker-Compose)
- [Bitbucket Pipelines](https://github.com/tfirdaus/wp-docklines/wiki/Bitbucket-Pipelines)
