#!/usr/bin/env bash

/home/ubuntu/fabric-starter/network.sh -m down
docker rm -f $(docker ps -aq)
docker volume rm $(docker volume ls -q -f "name=dockercompose_*")
docker volume prune -f
docker ps -a

###########################################################################
# Start
###########################################################################
if [ "$DEBUG_NOT_REMOVE_OLD_ARTIFACTS" == "" ]; then #sometimes in debug need not to remove old artifacts
    /home/ubuntu/fabric-starter/network.sh -m removeArtifacts
fi

#generate peer artifacts and configure as a remote org (not main) - update hosts files with orderer\www IPs
/home/ubuntu/fabric-starter/network.sh -m generate-peer -o $THIS_ORG -R true

