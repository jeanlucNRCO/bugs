FROM php:7-apache

COPY . /var/www/html

COPY bugs-apache.conf /etc/apache2/sites-enabled/000-crm.conf

COPY config.env.app.php /var/www/html/config.app.php

RUN rm -rf install

# Configuration apache
RUN a2enmod rewrite

# Configuration php
RUN docker-php-ext-install pdo pdo_mysql mysqli

# installation

WORKDIR /var/www/html

ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Nettoyage apt-get
RUN rm -rf /var/lib/apt/lists/* && apt-get clean

RUN chown -R www-data:www-data /var/www/html
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 770 uploads

# Redémarrage de apache
RUN service apache2 restart
