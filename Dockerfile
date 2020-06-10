# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: glibc
# Minimum Panel Version: 0.7.0
# ----------------------------------
FROM        alpine:latest

LABEL       author="Michael Parker" maintainer="parker@pterodactyl.io"

RUN         apk add --no-cache --update bash git openssh-client rsync ca-certificates \
            && adduser -D -h /home/container container

RUN cd /home/daemon-data/789110d7-b247-40ca-9cbe-9ff6dedd82f4/test \        
    git clone -b master https://$GTOKEN:x-oauth-basic@github.com/darksaid98/everlife.git /home/container/test

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/ash", "/entrypoint.sh"]
