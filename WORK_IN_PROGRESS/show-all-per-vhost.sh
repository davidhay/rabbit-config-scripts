#!/bin/bash

HOST=localhost
PORT=15672

while getopts u:p: option
do
case "${option}"
in
u) USER=${OPTARG};;
p) PASSWORD=${OPTARG};;
esac
done

function outputLine(){
  echo "---------------------------------------------";
}

outputLine
echo "user[$USER]host[$HOST]port[$PORT]."
outputLine

function rabbitadm() {
	rabbitmqadmin --host=$HOST --port=$PORT --user=$USER --password=$PASSWORD "$@"
}
function showResourcesForVhost() {
	local vhost=$1
	echo "showResourcesFoVhost[$vhost]"
	local queues=$(rabbitadm --vhost=$vhost -f bash list queues name )
	# QUEUES
	if [[ $queues == "No items" ]]; then
		echo "queues for [$vhost]:[]"
	else
		echo "queues for [$vhost]:[$queues]"
	fi
	# EXCHANGES
	local exchanges=$(rabbitadm --vhost=$vhost -f bash list exchanges name )
	if [[ $exchanges == "No items" ]]; then
		echo "exchanges for [$vhost]:[]"
	else
		echo "exchanges for [$vhost]:[$exchanges]"
	fi
	# BINDINGS
	echo 'bindings'
	rabbitadm --vhost=$vhost vhost source destination routing_key
	echo '----'
}

vhosts=$(rabbitadm -f bash list vhosts name)
for vhost in $vhosts; do
	showResourcesForVhost $vhost
	outputLine
done
exit

