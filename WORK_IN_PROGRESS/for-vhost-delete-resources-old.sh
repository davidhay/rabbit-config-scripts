#!/bin/bash

while getopts u:p:v: option
do
case "${option}"
in
u) USER=${OPTARG};;
p) PASSWORD=${OPTARG};;
v) VHOST=${OPTARG};;
esac
done

source ./common.sh

function outputItems() {
	local prefix=$1
	local items=$2
	local theItems=$(echo $items)
	echo "$prefix [$theItems]"
}

queues=$(rabbitadm -f bash -q list queues name)
exchanges=$(rabbitadm -f bash -q list exchanges name)
outputItems "for vhost [$VHOST] : BEFORE Q " $queues
outputItems "for vhost [$VHOST] : BEFORE EX" $exchages

for qq in $queues; do
	echo "queue to delete is [${qq}]"
	rabbitadm delete --quiet queue name=$qq
done

for ex in $exchanges; do
	if [[ "$ex" =~ ^amq.* ]]; then
		echo "  not deleting [${ex}]"
	else
		echo "non-system exchange to delete is [${ex}]"
		rabbitadm delete --quiet exchange name=$ex
	fi
done

queues=$(rabbitadm -f bash -q list queues name)
exchanges=$(rabbitadm -f bash -q list exchanges name)
outputItems "for vhost [$VHOST] : AFTER Q " $queues
outputItems "for vhost [$VHOST] : AFTER EX" $exchages

echo "Finished deleting Queues and non-system Exchanges for vhost [$VHOST]."
