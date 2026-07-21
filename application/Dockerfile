FROM wordpress:6-php8.3-apache

LABEL org.opencontainers.image.title="Netology WordPress application" \
      org.opencontainers.image.description="Web application for connect MySQL"

RUN a2enmod rewrite

COPY uploads.ini /usr/local/etc/php/conf.d/uploads.ini

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=5s --start-period=60s --retries=3 \
  CMD php -r '$socket = @fsockopen("127.0.0.1", 80); exit($socket ? 0 : 1);'