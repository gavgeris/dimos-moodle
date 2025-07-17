#!/bin/bash

# Start PHP-FPM in the background
/opt/bitnami/php/sbin/php-fpm --daemonize

# Execute the original entrypoint with all arguments passed to this script
exec /opt/bitnami/scripts/moodle/entrypoint.sh "$@"