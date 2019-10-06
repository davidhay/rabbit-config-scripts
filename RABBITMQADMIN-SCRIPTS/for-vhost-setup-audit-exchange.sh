#!/bin/bash

source ./common.sh

getOptsUsernamePasswordVhost $@

vhostExists=$(doesVhostExist)
if [[ $vhostExists != "Y" ]]; then
	echo "The vhost [$VHOST] does not exist."
	exit -1
fi

export SYS_EX_UNROUTED="sys.ex.unrouted"
export SYS_EX_DEAD_LETTER="sys.ex.dead.letter"

export VHOST_AUDIT_EX="sys.ex.audit"
export VHOST_AUDIT_Q1="sys.q.audit.01"
echo "VHOST_AUDIT_EX [$VHOST_AUDIT_EX]"
echo "VHOST_AUDIT_Q1 [$VHOST_AUDIT_Q1]"

rabbitadmForVhost delete exchange name="$VHOST_AUDIT_EX"
rabbitadmForVhost declare exchange name="$VHOST_AUDIT_EX" type="fanout" durable="true"

rabbitadmForVhost delete queue name="$VHOST_AUDIT_Q1"
rabbitadmForVhost declare queue name="$VHOST_AUDIT_Q1" 

rabbitadmForVhost declare binding source="$VHOST_AUDIT_EX" destination="$VHOST_AUDIT_Q1" destination_type="queue"

echo "START AUDIT BINDINGS"
exchanges=$(rabbitadmForVhost list exchanges -f bash) 
for exchange in $exchanges; do
	# Not an amq exchange
	if [[ $exchange == "$VHOST_AUDIT_EX" ]];then
		continue;
	fi
	# Not the audit exchange
	if [[ $exchange =~ ^amq.*$ ]];then
		continue;
	fi
	# Not the dead letter (unprocessed) exchange
	if [[ $exchange == "$DEAD_LETTER_EX" ]];then
		continue;
	fi
	# Not the un-routed exchange
	if [[ $exchange == "$UN_ROUTED_EX" ]];then
		continue;
	fi
	echo "exchange is $exchange"
	rabbitmqadmin --user=$RBT_USER --password=$RBT_PASSWD --vhost=$VHOST \
		declare binding \
		source="$exchange" \
		destination="$VHOST_AUDIT_EX" destination_type="exchange" \
		routing_key="#"
done
echo "END AUDIT BINDINGS"

rabbitadmForVhost list bindings
echo "FINISHED"

