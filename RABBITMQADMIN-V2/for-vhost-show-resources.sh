#!/bin/bash

source ./common.sh

getOptsUsernamePasswordVhost $@

echo "Exchanges for [$VHOST]"
rabbitadmForVhost list exchanges vhost name type
echo

echo "Queues for [$VHOST]"
rabbitadmForVhost list queues vhost name messages
echo

echo "Bindings for [$VHOST]"
rabbitadmForVhost list bindings vhost source destination routing_key
echo


