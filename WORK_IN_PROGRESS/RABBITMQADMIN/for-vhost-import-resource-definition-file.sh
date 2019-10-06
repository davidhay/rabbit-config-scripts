#!/bin/bash

HOST=localhost
PORT=15672

while getopts u:p:v:f: option
do
case "${option}"
in
u) USER=${OPTARG};;
p) PASSWORD=${OPTARG};;
v) VHOST=${OPTARG};;
f) BROKER_DEFINITIONS_FILE=${OPTARG};;
esac
done

function rabbitadm() {
	rabbitmqadmin --host=$HOST --port=$PORT --vhost=$VHOST --user=$USER --password=$PASSWORD "$@"
}
function showVhostResources() {
	./for-vhost-show-resources.sh -u $USER -p $PASSWORD -v $VHOST
}
function deleteVhostResources() {
	./for-vhost-show-resources.sh -u $USER -p $PASSWORD -v $VHOST
}

deleteVhostResources

echo "Loading the broker definition file [$BROKER_DEFINITIONS_FILE] into [$VHOST]"
rabbitadm import $BROKER_DEFINITIONS_FILE

showVhostResources
echo "Done."
