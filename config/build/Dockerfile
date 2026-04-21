FROM moodlehq/moodle-php-apache:8.3

# In your Dockerfile, after FROM moodlehq/moodle-php-apache:8.3
COPY config/apache/mpm.conf /etc/apache2/conf-available/mpm.conf
RUN a2enconf mpm

# Install extra tools + phpredis extension + Greek locale
RUN apt-get update && apt-get install -y \
    wget unzip zip nano curl git locales \
    && sed -i 's/# el_GR.UTF-8 UTF-8/el_GR.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen \
    && rm -rf /var/lib/apt/lists/*

ENV LANG=el_GR.UTF-8 \
    LANGUAGE=el_GR:el \
    LC_ALL=el_GR.UTF-8

# Download Moodle 5.1 into webroot
# moodlehq/moodle-php-apache uses /var/www/html/public as docroot for 5.1+
RUN wget -q https://download.moodle.org/download.php/direct/stable501/moodle-5.1.tgz \
    && tar -xzf moodle-5.1.tgz -C /tmp \
    && cp -a /tmp/moodle/. /var/www/html/ \
    && rm -rf moodle-5.1.tgz /tmp/moodle

# Greek language pack (bundled in webroot so it is available before moodledata is populated)
RUN mkdir -p /var/www/html/lang \
    && wget -q https://download.moodle.org/download.php/direct/langpack/5.1/el.zip \
    && unzip -q el.zip -d /var/www/html/lang/ \
    && rm el.zip

# Moodle 5.1+ uses a /public subdirectory as the actual web root
# The moodlehq image handles this via the 10-wwwroot.sh entrypoint script automatically

# Create moodledata directory (outside webroot — important for security)
RUN mkdir -p /var/www/moodledata \
    && chown -R www-data:www-data /var/www/html \
    && chown -R www-data:www-data /var/www/moodledata \
    && chmod -R 755 /var/www/html \
    && chmod 770 /var/www/moodledata

# Install Moosh
RUN cd /opt && \
    wget https://moodle.org/plugins/download.php/39220/moosh_moodle51_2025121901.zip && \
    unzip moosh_moodle51_2025121901.zip && \
    ln -s /opt/moosh/moosh.php /usr/local/bin/moosh && \
    rm moosh_moodle51_2025121901.zip

# PHP settings via ini file (moodlehq way)
COPY config/php/moodle.ini /usr/local/etc/php/conf.d/moodle.ini

# Moodle config.php
COPY config/moodle/config.php /var/www/html/config.php
RUN chown www-data:www-data /var/www/html/config.php

# In your Dockerfile
COPY config/docker-entrypoint.d/00-fix-permissions.sh /docker-entrypoint.d/00-fix-permissions.sh
RUN chmod +x /docker-entrypoint.d/00-fix-permissions.sh

WORKDIR /var/www/html
