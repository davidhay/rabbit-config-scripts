#!/bin/bash

source ./common.sh

getOptsUsernamePassword $@

rabbitadm list exchanges vhost name type
