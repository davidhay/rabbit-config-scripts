#!/bin/bash

source ./common.sh

getOptsUsernamePasswordVhostFile $@

function showVhostResources() {
	./for-vhost-show-resources.sh -u $USER -p $PASSWORD -v $VHOST
}
function deleteVhostResources() {
	./for-vhost-show-resources.sh -u $USER -p $PASSWORD -v $VHOST
}

if [[ ! -f $RABBIT_CONFIG_FILE ]]; then
    echo "Rabbit Config file [$RABBIT_CONFIG_FILE] not found!"
    exit -1
fi

echo "Deleting existing broker definitions for [$VHOST]"
deleteVhostResources

rabbitadm declare vhost name=$VHOST

echo "Importing the broker definition file [$RABBIT_CONFIG_FILE] into vhost[$VHOST]"
rabbitadmForVhost import $RABBIT_CONFIG_FILE

showVhostResources
echo "Finished importing broker definition file [$RABBIT_CONFIG_FILE] into vhost[$VHOST]"
