#!/bin/ash
cd /home/container

# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Auto Clearing Cache for FiveM Servers
if [ -d "/home/container/cache/" ] && [ -d "/home/container/cache/files/" ]; then
    echo "Clearing Cache..."
    rm -r /home/container/cache/files/
    sleep 5s
    echo "Cache cleared..."
fi


# Run the Server
eval ${MODIFIED_STARTUP}
