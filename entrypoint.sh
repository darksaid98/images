#!/bin/bash
cd /home/container

# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

# Auto update resources from git.
if [ "$GIT_ENABLED" = "true" ]; then
  echo "Wait, preparing to update.";
  sleep 1s
  cd /home/container/resources
  git pull https://${GIT_USERNAME}:${GIT_TOKEN}@github.com/${GIT_USERNAME}/${GIT_REPOSITORYNAME}.git ${GIT_BRANCH} && echo "Updated server from git." || echo "Update failed."
  cd /home/container 
fi

sleep 1s
# Auto clearing cache for FiveM servers.
if [ "$CACHE_CLEAR" = "true" ]; then
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
fi

# Replace Startup Variables
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo -e ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
eval ${MODIFIED_STARTUP}