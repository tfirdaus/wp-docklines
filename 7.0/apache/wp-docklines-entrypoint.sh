#!/usr/bin/env bash
set -euo pipefail

# WordPress working directory.
WORDPRESS_ROOT=/var/www/html

# Register WPackagist repository.
cat > $WORDPRESS_ROOT/composer.json <<-'EOF'
{"repositories":[{"type":"composer","url":"https://wpackagist.org"}]}
EOF

# Set the file permission to the web user.
chown www-data:www-data $WORDPRESS_ROOT/composer.json

# Execute the Docker Entrypoint from the WordPress image.
docker-entrypoint.sh "$1"
exec "$@"
