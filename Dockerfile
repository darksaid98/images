# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: glibc
# Minimum Panel Version: 0.7.0
# ----------------------------------
FROM        alpine:latest

LABEL       author="Michael Parker" maintainer="parker@pterodactyl.io"

RUN         apk add --no-cache --update bash git openssh-client rsync ca-certificates \
            && adduser -D -h /home/container container

RUN git clone https://$GTOKEN@github.com/darksaid98/everlife.git /home/container/test

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/ash", "/entrypoint.sh"]
