#!/bin/bash

#!/bin/bash

HOST=localhost
PORT=15672

while getopts u:p:v: option
do
case "${option}"
in
u) USER=${OPTARG};;
p) PASSWORD=${OPTARG};;
v) VHOST=${OPTARG};;
esac
done

function rabbitadm() {
	rabbitmqadmin --host=$HOST --port=$PORT --vhost=$VHOST  --user=$USER --password=$PASSWORD "$@"
}

echo "Queues for [$VHOST]"
rabbitadm list queues vhost name messages
echo

echo "Exchanges for [$VHOST]"
rabbitadm list exchanges vhost name type
echo

echo "Bindings for [$VHOST]"
rabbitadm list bindings vhost source destination routing_key
echo


