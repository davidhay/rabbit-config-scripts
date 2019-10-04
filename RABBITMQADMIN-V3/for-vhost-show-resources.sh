#!/bin/bash

source ./common.sh

getOptsUsernamePasswordVhost $@

vhostExists=$(doesVhostExist)
if [[ $vhostExists != "Y" ]]; then
	echo "The vhost [$VHOST] does not exist."
	exit -1
fi

echo "Exchanges for [$VHOST]"
rabbitadmForVhost list exchanges vhost name type
echo

echo "Queues for [$VHOST]"
rabbitadmForVhost list queues vhost name messages
echo

echo "Bindings for [$VHOST]"
rabbitadmForVhost list bindings vhost source destination routing_key
echo


