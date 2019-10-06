#!/bin/bash

source ./common.sh

getOptsUsernamePasswordVhost $@

#could do check here to see if vhost exists first?
rabbitadm delete vhost name=$VHOST
rabbitadm declare vhost name=$VHOST

echo "Finished deleting Exhchanges, Queues & Bindings for vhost [$VHOST]."
