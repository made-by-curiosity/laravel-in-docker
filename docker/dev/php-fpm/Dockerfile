FROM php:8.2-fpm-alpine

# install system dependencies and PHP extensions, use no-cache to avoid caching the index(better than using apk update)
# clean up the source files after installing PHP extensions with docker-php-source delete
RUN apk add --no-cache \
    libpng-dev libjpeg-turbo-dev libwebp-dev libxpm-dev freetype-dev \
    oniguruma-dev icu-dev libxml2-dev zip unzip git curl bash \
    && docker-php-ext-install \
        pdo pdo_mysql mbstring intl xml gd opcache \
    && docker-php-source delete 

# create a non-root user and group to run the application for security reasons and matching file permissions and ownership for mounted host volumes
RUN addgroup -g 1000 appgroup && adduser -u 1000 -G appgroup -s /bin/sh -D appuser
USER appuser

CMD ["php-fpm"]