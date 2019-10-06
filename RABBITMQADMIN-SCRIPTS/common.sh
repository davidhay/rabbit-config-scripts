#!/bin/bash

HOST=localhost
PORT=15672

function getOptsUsernamePassword(){
	while getopts u:p: option
	do
	case "${option}"
	in
	u) USER=${OPTARG};;
	p) PASSWORD=${OPTARG};;
	esac
	done
#	echo "getOptUsernamePassword [$USER] [$PASSWORD]"
}

function getOptsUsernamePasswordVhost(){
	while getopts u:p:v: option
	do
	case "${option}"
	in
	u) USER=${OPTARG};;
	p) PASSWORD=${OPTARG};;
	v) VHOST=${OPTARG};;
	esac
	done
#	echo "getOptsUsernamePasswordVhost [$USER] [$PASSWORD] [$VHOST]"
}

function getOptsUsernamePasswordVhostFile(){
	while getopts u:p:v:f: option
	do
	case "${option}"
	in
	u) USER=${OPTARG};;
	p) PASSWORD=${OPTARG};;
	v) VHOST=${OPTARG};;
	f) RABBIT_CONFIG_FILE=${OPTARG};;
	esac
	done
#	echo "getOptsUsernamePasswordVhostFile [$USER] [$PASSWORD] [$VHOST] [$RABBIT_CONFIG_FILE]"
}

function rabbitadm() {
	ARGS="--host=$HOST --port=$PORT --user=$USER --password=$PASSWORD $@"
	#echo "ARGS are [$ARGS]"
	rabbitmqadmin $ARGS
}

function rabbitadmForVhost() {
	ARGS="--vhost=$VHOST $@"
	#echo "ARGS are [$ARGS]"
	rabbitadm "$ARGS"
}
function doesVhostExist(){
	local VHOSTS=$(rabbitadm list vhosts -f bash)
	local found=false
	local tmpVhost
	for tmpVhost in $VHOSTS; do
		if [[ $VHOST == $tmpVhost ]]; then
			found=true;
			break;
		fi
	done
	if [[ $found == true ]]; then
		echo "Y"
	else
		echo "N"
	fi
}

export -f getOptsUsernamePassword
export -f getOptsUsernamePasswordVhost
export -f getOptsUsernamePasswordVhostFile
export -f rabbitadm
export -f rabbitadmForVhost
export -f doesVhostExist

