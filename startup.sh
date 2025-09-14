#!/bin/bash

# Exit immediately if a command fails
set -e

# Go into the app root
cd /home/site/wwwroot

echo ">>> Copying custom nginx config..."
cp /home/site/wwwroot/default /etc/nginx/sites-available/default

echo ">>> Reloading nginx..."
service nginx reload

echo ">>> Running database migrations..."
php artisan migrate --force

echo ">>> Caching Laravel config, routes, and views..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo ">>> Starting PHP-FPM..."
php-fpm
