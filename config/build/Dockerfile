# Use Bitnami Moodle as the base image
#FROM docker.io/bitnami/moodle:latest
FROM docker.io/bitnamilegacy/moodle:5.0.1-debian-12-r6

# Install necessary build tools and dependencies
RUN install_packages build-essential autoconf libtool git wget zip unzip nano curl 

# Clone, build, and install php-redis
RUN git clone https://github.com/phpredis/phpredis.git && \
    cd phpredis && \
    /opt/bitnami/php/bin/phpize && \
    ./configure --with-php-config=/opt/bitnami/php/bin/php-config && \
    make && make install && \
    echo "extension=redis.so" > /opt/bitnami/php/etc/conf.d/redis.ini && \
    cd .. && rm -rf phpredis

# Download and install Moosh
RUN cd /opt && \
    wget https://moodle.org/plugins/download.php/33902/moosh_moodle45_2024111400.zip && \
    unzip moosh_moodle45_2024111400.zip && \
    ln -s /opt/moosh/moosh.php /usr/local/bin/moosh && \
    rm moosh_moodle45_2024111400.zip  # Clean up zip file

# Clean up unnecessary packages and cache
RUN apt-get remove -y build-essential autoconf libtool git && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# Copy the pre-created php-fpm.conf file into the correct location
COPY extra/php-fpm.conf /opt/bitnami/apache2/conf/extra/php-fpm.conf

# Step 2: Set the socket ownership and permissions in php-fpm.conf (For using socket only)
#RUN sed -i 's/^;\(listen.owner = daemon\)/\1/' /opt/bitnami/php/etc/php-fpm.d/www.conf && \
#    sed -i 's/^;\(listen.group = daemon\)/\1/' /opt/bitnami/php/etc/php-fpm.d/www.conf && \
#    sed -i 's/^;\(listen.mode = 0660\)/\1/' /opt/bitnami/php/etc/php-fpm.d/www.conf

# Step 2: Modify Apache httpd.conf
RUN sed -i 's|#LoadModule proxy_module modules/mod_proxy.so|LoadModule proxy_module modules/mod_proxy.so|' /opt/bitnami/apache2/conf/httpd.conf && \
    sed -i 's|#LoadModule proxy_fcgi_module modules/mod_proxy_fcgi.so|LoadModule proxy_fcgi_module modules/mod_proxy_fcgi.so|' /opt/bitnami/apache2/conf/httpd.conf && \
    sed -i 's|LoadModule php_module modules/libphp.so|#LoadModule php_module modules/libphp.so|' /opt/bitnami/apache2/conf/httpd.conf && \
    echo 'Include "/opt/bitnami/apache2/conf/extra/php-fpm.conf"' >> /opt/bitnami/apache2/conf/httpd.conf && \
    echo "Timeout 600" >> /opt/bitnami/apache2/conf/httpd.conf && \
    echo "KeepAlive On" >> /opt/bitnami/apache2/conf/httpd.conf && \
    echo "KeepAliveTimeout 100" >> /opt/bitnami/apache2/conf/httpd.conf


# Create a custom entrypoint wrapper
COPY --chmod=755 custom-entrypoint.sh /
ENTRYPOINT ["/custom-entrypoint.sh"]
CMD ["/opt/bitnami/scripts/moodle/run.sh"]


# Set working directory
WORKDIR /bitnami/moodle