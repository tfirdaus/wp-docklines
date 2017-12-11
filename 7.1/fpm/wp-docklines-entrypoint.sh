#!/usr/bin/env bash
set -euo pipefail

# Set the wp-content in a separate directory and symlink it to the actual
# working directory.
#
# This makes it possible to cache cache the directory in the CI like
# Bitbucket Pipelines and to avoid being overidden when the WordPress
# files are copied to the workcing directory.
WP_CONTENT_ROOT=/var/www/wp-content
WP_CONTENT_WORK=/var/www/html/wp-content

if [[ ! -d "$WP_CONTENT_ROOT" ]]; then
	echo >&2 "NOTICE: 📁 $WP_CONTENT_ROOT is not exist. Creating the directory now."
	mkdir $WP_CONTENT_ROOT
fi

# Reset the directory permission
chown www-data:www-data $WP_CONTENT_ROOT

# Copy the WordPress Core files
# https://github.com/docker-library/wordpress/blob/master/php5.6/apache/docker-entrypoint.sh#L27-L51
if ! [ -e index.php -a -e wp-includes/version.php ]; then
	echo >&2 "NOTICE: 💬 WordPress not found in $PWD - 🔄 copying now..."
	if [ "$(ls -A)" ]; then
		echo >&2 "WARNING: ⚠️ $PWD is not empty - press Ctrl+C now if this is an error!"
		( set -x; ls -A; sleep 10 )
	fi
	tar cf - --one-file-system -C /usr/src/wordpress . | tar xf -
	echo >&2 "SUCCESS: ✅ Complete! WordPress has been successfully copied to $PWD"
	if [ ! -e .htaccess ]; then
		# NOTE: The "Indexes" option is disabled in the php:apache base image
		cat > .htaccess <<-'EOF'
			# BEGIN WordPress
			<IfModule mod_rewrite.c>
			RewriteEngine On
			RewriteBase /
			RewriteRule ^index\.php$ - [L]
			RewriteCond %{REQUEST_FILENAME} !-f
			RewriteCond %{REQUEST_FILENAME} !-d
			RewriteRule . /index.php [L]
			</IfModule>
			# END WordPress
		EOF
		chown www-data:www-data .htaccess
	fi
fi

# Verify if the wp-content is a symlink and pointing to the correct directory
if ! [[ -L "$WP_CONTENT_WORK" ]] || ! [[ "$(readlink -- "$WP_CONTENT_WORK")" = $WP_CONTENT_ROOT ]]; then
	if [[ -d "$WP_CONTENT_WORK" ]]; then
		rm -r $WP_CONTENT_WORK
	fi

	# Create a symlink to the /wp-content root directory
	ln -sfn $WP_CONTENT_ROOT $WP_CONTENT_WORK
	if [ $? -eq 0 ]; then
		echo >&2 "SUCCESS: ✅ Symlink to $WP_CONTENT_ROOT has been created."
	fi
fi

# Execute the Docker Entrypoint from the WordPress image.
docker-entrypoint.sh "$1"

exec "$@"
