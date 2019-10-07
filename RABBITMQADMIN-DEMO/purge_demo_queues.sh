#!/bin/bash

echo "IN purge demo queues"

echo "RBT_USER $RBT_USER"
echo "RBT_PASSWD $RBT_PASSWD"
echo "VHOST $VHOST"

function purge_queue(){
	QUEUE_NAME=$1
	rabbitmqadmin --user=$RBT_USER --password=$RBT_PASSWD --vhost=$VHOST purge queue name=$QUEUE_NAME
}

purge_queue "q.type1"
purge_queue "q.type2"
purge_queue "sys.q.audit.01"
purge_queue "sys.q.dead.letter.01"
purge_queue "sys.q.unrouted"