# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: glibc
# Minimum Panel Version: 0.7.0
# ----------------------------------
FROM alpine:latest

LABEL author="Michael Parker" maintainer="parker@pterodactyl.io"

RUN apk add --no-cache --update ca-certificates \
    && adduser -D -h /home/container container

RUN apk --update add git less openssh && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/* 

USER container
ENV USER=container HOME=/home/container
VOLUME /git
WORKDIR /home/container

ENTRYPOINT ["git"]
COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/ash", "/entrypoint.sh", "--help"]