#!/bin/bash

source ./common.sh

getOptsUsernamePasswordVhost $@

function showVhostResources() {
	./for-vhost-show-resources.sh -u $USER -p $PASSWORD -v $VHOST
}

vhostExists=$(doesVhostExist)
if [[ $vhostExists != "Y" ]]; then
	echo "The vhost [$VHOST] does not exist."
	exit -1
fi

filename="exported-rabbit-config-for-$VHOST.json"

echo "Exporting the broker definition file [$BROKER_DEFINITIONS_FILE] for vhost[$VHOST] to [$filename]"

rabbitadmForVhost export $filename

echo "Finished export broker definition file [$BROKER_DEFINITIONS_FILE] for vhost[$VHOST] to [$filename]"
