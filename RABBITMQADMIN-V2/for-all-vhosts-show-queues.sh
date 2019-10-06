#!/bin/bash

source ./common.sh

getOptsUsernamePassword $@

rabbitadm list queues vhost name messages
