FROM ubuntu:22.04

# Prevent tzdata from asking interactive questions
ENV DEBIAN_FRONTEND=noninteractive

# Install Apache, PHP, MariaDB and tools
RUN apt-get update && \
    apt-get install -y apache2 php php-mysql libapache2-mod-php \
    mariadb-server wget unzip tzdata && \
    rm -rf /var/lib/apt/lists/*

# Reset frontend back to normal (good practice)
ENV DEBIAN_FRONTEND=dialog

# Download WordPress
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xvzf latest.tar.gz && \
    rm latest.tar.gz && \
    mv wordpress /var/www/html/ && \
    chown -R www-data:www-data /var/www/html/wordpress

# Configure Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    a2enmod rewrite

# Expose web port
EXPOSE 80

# Start both MariaDB and Apache when container runs
CMD service mysql start && \
    mysql -e "CREATE DATABASE IF NOT EXISTS wpdb; \
              CREATE USER IF NOT EXISTS 'wpuser'@'localhost' IDENTIFIED BY 'wppass'; \
              GRANT ALL PRIVILEGES ON wpdb.* TO 'wpuser'@'localhost'; \
              FLUSH PRIVILEGES;" && \
    apachectl -D FOREGROUND
