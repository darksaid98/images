#!/bin/ash
cd /home/container

# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

# Auto Clearing Cache for FiveM Servers
if [ -d "/home/container/cache/" ] && [ -d "/home/container/cache/files/" ]; then
    echo ""
    echo ""
    echo "Wait..."
    echo ""
    echo ""
    sleep 1s
    echo ""
    echo ""
    echo "Deleting..."
    rm -r /home/container/cache/files/
    echo ""
    echo ""
    while [ -d "/home/container/cache/files/" ]; do
      sleep 1s
    done
    echo ""
    echo ""
    echo "The cache has been cleared."
    echo ""
    echo ""
fi

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
eval ${MODIFIED_STARTUP}
