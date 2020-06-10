#!/bin/ash
cd /home/container

# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

#git config user.name "darksaid98"
#git config user.email "darksaid9889@gmail.com"

sleep 1s
cd /home/container/resources
git pull https://${GTOKEN}@github.com/darksaid98/everlife.git /home/container/resources && echo "Updated from git" || echo "Update failed"

cd /home/container
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
