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

function rabbitadm() {
	rabbitmqadmin --host=$HOST --port=$PORT --user=$USER --password=$PASSWORD "$@"
}

echo "VHOSTS"
rabbitadm list vhosts
echo
