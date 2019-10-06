#!/bin/bash

source ./common.sh

getOptsUsernamePasswordVhost $@

result=$(doesVhostExist)
echo "The vhost [$VHOST] exists ? $result"
