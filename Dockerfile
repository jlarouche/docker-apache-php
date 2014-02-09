FROM ubuntu:12.04

MAINTAINER jlarouche

# Install the relevant packages
RUN apt-get update && apt-get install apache2 libapache2-mod-php5 -y

# Enable the php mod we just installed
RUN a2enmod php5

# Update our apache sites available with the config we created
ADD apache-config.conf /etc/apache2/sites-enabled/000-default

# expose port 8080 so that our webserver can respond to requests.
EXPOSE 80

# Manually set the apache environment variables in order to get apache to work immediately.
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

# Execute the apache daemon in the foreground so we can treat the container as an 
# executeable and it wont immediately return.
CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
