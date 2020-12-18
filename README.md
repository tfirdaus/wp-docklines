# WP Docklines

[![Docker Automated build](https://img.shields.io/docker/automated/tfirdaus/wp-docklines.svg?style=flat)](https://hub.docker.com/r/tfirdaus/wp-docklines/) [![Docker Pulls](https://img.shields.io/docker/pulls/tfirdaus/wp-docklines.svg?style=flat)](https://hub.docker.com/r/tfirdaus/wp-docklines/) [![Docker Build Status](https://img.shields.io/docker/build/tfirdaus/wp-docklines.svg?style=flat)](https://hub.docker.com/r/tfirdaus/wp-docklines/) [![Travis](https://img.shields.io/travis/tfirdaus/wp-docklines.svg?style=flat)](https://travis-ci.org/tfirdaus/wp-docklines) [![License](https://img.shields.io/github/license/tfirdaus/wp-docklines.svg?style=flat)](https://github.com/tfirdaus/wp-docklines)

> [Docker](https://www.docker.com/) images for setting up and running a WordPress development environment.

Each of these Docker images include:

- [WordPress](https://wordpress.org/download/)
- [WP-CLI](http://wp-cli.org/)
- [Subversion](https://subversion.apache.org/)
- [Git](https://git-scm.com/)
- [Composer](https://getcomposer.org/)

See the following table for version of each package included:

## PHP Images

| Image | WP-CLI | SVN | Git | Composer |
| --- | --- | --- | --- | --- |
| `php7.3-apache`     | 2.4.0 | 1.10.4 | 2.20.1 | 1.10.17 |
| `php7.3-fpm`        | 2.4.0 | 1.10.4 | 2.20.1 | 1.10.17 |
| `php7.3-fpm-alpine` | 2.4.0 | 1.13.0 | 2.26.2 | 1.10.17 |
| `php7.4-apache`     | 2.4.0 | 1.10.4 | 2.20.1 | 1.10.17 |
| `php7.4-fpm`        | 2.4.0 | 1.10.4 | 2.20.1 | 1.10.17 |
| `php7.4-fpm-alpine` | 2.4.0 | 1.13.0 | 2.26.2 | 1.10.17 |
| `php8.0-apache`     | 2.4.0 | 1.10.4 | 2.20.1 | 1.10.17 |
| `php8.0-fpm`        | 2.4.0 | 1.10.4 | 2.20.1 | 1.10.17 |
| `php8.0-fpm-alpine` | 2.4.0 | 1.13.0 | 2.26.2 | 1.10.17 |

## PHP Libraries / Extensions

The image also includes the following packages that might be needed for deployment or running a few select WP-CLI commands that require interaction with the `mysql` command such as `wp db import` and `wp db export`:

- `mysql-client`
- `unzip`
- `ssh-client`

## Usage

You'll need to install Docker ([Mac](https://www.docker.com/docker-mac)|[Windows](https://www.docker.com/docker-windows)) on your machine. The image is available in [Docker Hub](https://hub.docker.com/), and you can run `docker pull tfirdaus/wp-docklines` command to pull the latest image which defaults to the `latest` tag or `php8.0-apache`. Have a look at the [Wiki](https://github.com/tfirdaus/wp-docklines/wiki) for a few real-world usages of these images:

- [Docker Compose](https://github.com/tfirdaus/wp-docklines/wiki/Docker-Compose)
- [Bitbucket Pipelines](https://github.com/tfirdaus/wp-docklines/wiki/Bitbucket-Pipelines)
