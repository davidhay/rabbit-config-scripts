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
	echo "getOptUsernamePassword [$USER] [$PASSWORD]"
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
	echo "getOptsUsernamePasswordVhost [$USER] [$PASSWORD] [$VHOST]"
}
function getOptsUsernamePasswordVhostFile(){
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
	echo "getOptsUsernamePasswordVhostFile [$USER] [$PASSWORD] [$VHOST] [$BROKER_DEFINITIONS_FILE]"
}

function rabbitdriver(){
	DOCKER_COMPOSE_SERVICE="composed-rabbit"
	CMD="rabbitmqadmin $@"
	echo "CMD IS [$CMD]"
	docker-compose exec $DOCKER_COMPOSE_SERVICE /bin/bash -c "$CMD"
}

function rabbitadm() {
	ARGS="--host=$HOST --port=$PORT --user=$USER --password=$PASSWORD $@"
	echo "ARGS are [$ARGS]"
	rabbitdriver "$ARGS"
}

function rabbitadmForVhost() {
	ARGS="--vhost=$VHOST $@"
	echo "ARGS are [$ARGS]"
	rabbitadm "$ARGS"
}

export -f getOptsUsernamePassword
export -f getOptsUsernamePasswordVhost
export -f getOptsUsernamePasswordVhostFile
export -f rabbitadm
export -f rabbitadmForVhost
