# Dump current env vars to file (available at container start)
printenv | grep -E 'MOODLE|MARIADB' > /etc/environment.cron
chmod 600 /etc/environment.cron

service cron start