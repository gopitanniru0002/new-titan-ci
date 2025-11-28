
FROM ubuntu:20.04
# Prevent interactive prompts during apt operations (build-time only)
ARG DEBIAN_FRONTEND=noninteractive
# Install Apache and curl, then clean apt cache and lists
RUN apt-get update && \
    apt-get install -y --no-install-recommends apache2 curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
# Apache's default web root
WORKDIR /var/www/html
# Extract tarball into /var/www/html
ADD titan.tar.gz /var/www/html/
# Copy your site files into /var/www/html
COPY ./titanfiles/ .
# Expose HTTP port
EXPOSE 80
# Run Apache in the foreground (Ubuntu uses apache2ctl)
CMD ["apache2ctl", "-D", "FOREGROUND"]
