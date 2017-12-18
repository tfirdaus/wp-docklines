#!/usr/bin/env bash
set -euo pipefail

# Create the Composer Home directory for user.
mkdir -p /var/www/.composer

# Register WPackagist repository.
cat > $(pwd)/composer.json <<-'EOF'
{"repositories":[{"type":"composer","url":"https://wpackagist.org"}]}
EOF

# Set the file permission to the web user.
chown www-data:www-data /var/www/.composer
chown www-data:www-data $(pwd)/composer.json

# Execute the Docker Entrypoint from the WordPress image.
docker-entrypoint.sh "$1"
exec "$@"
