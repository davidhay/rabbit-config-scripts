#!/bin/bash

source ./common.sh

getOptsUsernamePasswordVhost $@

vhostQueues=$(rabbitadmForVhost -f bash list queues)
if [[ "No items" = $vhostQueues ]]; then
	echo "There are no queues for vhost [$VHOST]"
	exit -1
fi
echo "BEFORE"
rabbitadmForVhost list queues vhost name messages

for vhostQueue in $vhostQueues; do
	rabbitadmForVhost -q purge queue name="$vhostQueue"
done

for x in 5 4 3 2 1; do
  echo -n "$x "
  sleep 1
done
echo ""
echo "AFTER"
rabbitadmForVhost list queues vhost name messages
