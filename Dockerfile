FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update --fix-missing && apt-get install -yq --no-install-recommends && \
    apt-get install -y software-properties-common && add-apt-repository ppa:ondrej/php && \
    apt-get install -y curl \
    apt-utils \
    git \
    apache2 \
    libapache2-mod-php7.2 \
    php7.2-cli \
    php7.2-pgsql \
	php7.2-mysql \
    php7.2-json \
    php7.2-curl \
    php7.2-gd \
    php7.2-ldap \
    php7.2-mbstring \
    php7.2-soap \
    php7.2-sqlite3 \
    php7.2-xml \
    php7.2-zip \
    php7.2-intl \
    php-imagick \
    # Install tools
    openssl \
    nano \
    graphicsmagick \
    imagemagick \
    ghostscript \
    iputils-ping \
    locales \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN locale-gen en_US.UTF-8 en_GB.UTF-8 de_DE.UTF-8 es_ES.UTF-8 fr_FR.UTF-8 it_IT.UTF-8 km_KH sv_SE.UTF-8 fi_FI.UTF-8

RUN a2enmod rewrite && a2enmod headers
COPY web.conf /etc/apache2/sites-available/
RUN a2dissite 000-default
RUN a2ensite web.conf
EXPOSE 80

WORKDIR /var/www/html
CMD chown -R www-data:www-data html/*
CMD apachectl -D FOREGROUND 