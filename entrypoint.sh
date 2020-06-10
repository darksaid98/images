#!/bin/ash
cd /home/container

# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

sleep 1s
echo ${GTOKEN};
echo {$GTOKEN};
echo $GTOKEN;
sleep 1s
git clone https://${GTOKEN}:x-oauth-basic@github.com/darksaid98/everlife.git /home/container/test && echo "Updated from git" || echo "Update failed";

# Auto clearing cache for FiveM servers
if [ -d "/home/container/cache/" ] && [ -d "/home/container/cache/files/" ]; then
    echo "Wait, inspecting cache.";
    sleep 1s
    echo "Deleting..."
    rm -r /home/container/cache/files/
    while [ -d "/home/container/cache/files/" ]; do
      sleep 1s
    done
    echo "The cache has been cleared."
fi

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
eval ${MODIFIED_STARTUP}
