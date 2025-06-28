FROM php:8.2-fpm-alpine

RUN docker-php-ext-install pdo pdo_mysql

# create a non-root user and group to run the application for security reasons and matching file permissions and ownership for mounted host volumes
RUN addgroup -g 1000 appgroup && adduser -u 1000 -G appgroup -s /bin/sh -D appuser
USER appuser
