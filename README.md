# WP-Docklines

[![Build Status](https://travis-ci.org/tfirdaus/wp-docklines.svg?branch=master)](https://travis-ci.org/tfirdaus/wp-docklines)

A custom [Docker](https://www.docker.com/) image to perform CI (Continuous Integration) or CD (Continuous Delivery) in services like [Bitbucket Pipelines](https://bitbucket.org/product/features/pipelines) or for setting up a local environment to develop WordPress plugins or themes locally in your computer. Each of these Docker images includes:

- The latest version of [WordPress package](https://wordpress.org/download/).
- [WP-CLI](http://wp-cli.org/)
- [PHPUnit](https://phpunit.de/)
- [PHPCS](https://github.com/squizlabs/PHP_CodeSniffer) with [WordPress Coding Standards](https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards)
- [Node.js](https://nodejs.org/en/)
- [Subversion](https://subversion.apache.org/)
- [Git](https://git-scm.com/)

## Usage
If you'd like to use it on your computer, you'll need to install Docker ([Mac](https://www.docker.com/docker-mac)|[Windows](https://www.docker.com/docker-windows)). The image is available in [Docker Hub](https://hub.docker.com/). Run `docker pull tfirdaus/wp-docklines` command to pull the latest image which default to the `latest` tag or `php7.2-fpm`. Have a look at the [Wiki](https://github.com/tfirdaus/wp-docklines/wiki) for the a few usages:

- [Docker Compose](https://github.com/tfirdaus/wp-docklines/wiki/Docker-Compose)
- Bitbucket Pipelines (soon)

## PHP Libraries / Extensions
Following the image origin at [WordPress Official Docker image](https://hub.docker.com/_/wordpress/), this image does not provide any additional PHP extensions or other libraries as well. There are an infinite number of possible plugins and including every PHP extension that exists would dramatically increase the image size.
