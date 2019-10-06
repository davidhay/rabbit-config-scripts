#!/bin/bash

while getopts u:p: option
do
case "${option}"
in
u) USER=${OPTARG};;
p) PASSWORD=${OPTARG};;
esac
done

source ./common.sh

echo "VHOSTS"
rabbitadm list vhosts
echo
