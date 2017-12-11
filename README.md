# WP-Docklines (Beta)

A custom Docker image for WordPress development. It can be used to perform CI/CD in services like Bitbucket Pipelines or for an environment to develop locally on your computer. This Docker image includes:
- The latest version of [WordPress package](https://wordpress.org/download/).
- [Composer](https://getcomposer.org/)
- [WP-CLI](http://wp-cli.org/)
- [PHPUnit](https://phpunit.de/)
- [PHPCS](https://github.com/squizlabs/PHP_CodeSniffer) with [WordPress Coding Standards](https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards)
- [Node.js](https://nodejs.org/en/)
- [Subversion](https://subversion.apache.org/)
- [Git](https://git-scm.com/)

## Usage
If you'd like to use it on your computer, you'll need to install Docker ([Mac](https://www.docker.com/docker-mac)|[Windows](https://www.docker.com/docker-windows)). The image is available in [Docker Hub](https://hub.docker.com/) and can be pulled with the `docker pull` command. More examples on the usage will be coming soon.

## PHP Libraries / Extensions
Following the image origin at [WordPress Official Docker image](https://hub.docker.com/_/wordpress/), this image does not provide any additional PHP extensions or other libraries as well. There are an infinite number of possible plugins and including every PHP extension that exists would dramatically increase the image size.

## Why?
Yes, there are a few Docker images for WordPress development. Yet I found most of these images are stacked with things that are not needed on most of my projects or are not suitable for the workflow. These images are built on top of those necessities; a Development environment with the similar _stacks_ to the Production environment of those websites that I'm working on. Eventually, it's become an opportunity to dig into Docker deeper.
