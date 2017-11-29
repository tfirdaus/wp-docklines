# WP-Docklines (Beta)

WP-Docklines is a custom Docker image for WordPress development. It can be used for peforming CI or for an environment to develop locally on your computer. This Docker image includes:
- The latest version of [WordPress package](https://wordpress.org/download/).
- [Composer](https://getcomposer.org/)
- [WP-CLI](http://wp-cli.org/)
- [PHPUnit](https://phpunit.de/)
- [PHPCS](https://github.com/squizlabs/PHP_CodeSniffer) with [WordPress Coding Standards](https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards)
- [Node.js](https://nodejs.org/en/)
- [Subversion](https://subversion.apache.org/)
- [Git](https://git-scm.com/)

## Usage
If you'd like to use it on your computer, you'll need to install Docker (<a href="https://www.docker.com/docker-mac">Mac</a>|<a href="https://www.docker.com/docker-windows">Windows</a>). The image is available in [Docker Hub](https://hub.docker.com/) and can be pulled with the <code>docker pull</code> command. More examples on the usage will be coming soon.

## PHP Libraries / Extensions
Following the image origin at <a href="https://hub.docker.com/_/wordpress/">WordPress Official Docker image</a>, this image does not provide any additional PHP extensions or other libraries as well. There are an infinite number of possible plugins and including every PHP extension that exists would dramatically increase the image size.
