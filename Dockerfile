# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: glibc
# Minimum Panel Version: 0.7.0
# ----------------------------------
FROM        alpine:latest

LABEL       author="Michael Parker" maintainer="parker@pterodactyl.io"

RUN apt-get update \        
    apt-get install -y git
RUN mkdir /home/container/test \      
    cd /home/container/test \        
    git clone -b master https://$GTOKEN:x-oauth-basic@github.com/darksaid98/everlife.git /home/container/test

RUN         apk add --no-cache --update ca-certificates \
            && adduser -D -h /home/container container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/ash", "/entrypoint.sh"]
