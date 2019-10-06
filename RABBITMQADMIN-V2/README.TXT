This folder contains scripts for examining and loading rabbit config.

These scripts execute the rabbitmqadmin command within the docker container itself.

It mostly works. It's slower than use rabbitmqadmin directly.

PROBLEM
=======
We have a problem getting the file onto the rabbit container.
We will have to copy it into the container first -  unless I can pipe it.
