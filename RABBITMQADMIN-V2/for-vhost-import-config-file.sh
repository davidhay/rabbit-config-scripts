#!/bin/bash

source ./common.sh

getOptsUsernamePasswordVhostFile $@

function showVhostResources() {
	./for-vhost-show-resources.sh -u $USER -p $PASSWORD -v $VHOST
}
function deleteVhostResources() {
	./for-vhost-show-resources.sh -u $USER -p $PASSWORD -v $VHOST
}

echo "Deleting existing broker definitions for [$VHOST]"
deleteVhostResources

echo "Importing the broker definition file [$BROKER_DEFINITIONS_FILE] into vhost[$VHOST]"
rabbitadmForVhost import $BROKER_DEFINITIONS_FILE

showVhostResources
echo "Finished importing broker definition file [$BROKER_DEFINITIONS_FILE] into vhost[$VHOST]"
