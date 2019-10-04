#!/bin/bash

source ./common.sh

getOptsUsernamePassword $@

echo "SHOW ALL VHOSTS"
rabbitadm list vhosts
echo
