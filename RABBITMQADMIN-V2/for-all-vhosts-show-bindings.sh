#!/bin/bash

source ./common.sh

getOptsUsernamePassword $@

rabbitadm list bindings vhost source destination routing_key
