#!/bin/bash

source ./common.sh

getOptsUsernamePasswordVhost $@

vhostExists=$(doesVhostExist)
if [[ $vhostExists != "Y" ]]; then
	echo "The vhost [$VHOST] does not exist."
	exit -1
fi
rabbitadm delete vhost name=$VHOST
