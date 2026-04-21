#!/bin/bash
docker exec -u www-data moodle php /var/www/html/admin/cli/install_database.php \
  --fullname="My Moodle Site" \
  --shortname="moodle" \
  --adminuser=admin \
  --adminpass=kanena11 \
  --adminemail=gavgeris@gmail.com \
  --agree-license