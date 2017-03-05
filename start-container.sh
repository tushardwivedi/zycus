#!/bin/bash
#
# SCRIPT:       start.sh
#
# AUTHOR:       Tushar Dwivedi
#
# DATE:         02-09-2017
#
# REV:          0.1.A
#
# PLATFORM:     Linux, UNIX, MAC OS
#
# PURPOSE:      This Script will build the image from dockerfile in current directory and start the conatiner. This script assumes that docker is installed in host machine. If running on Mac, please install docker-machine amd configure the terminal before running this script. 
#
# set -x        # Uncomment to debug the shell script.

docker build -t tushar/zycus:v1 .
docker run -d --name zycus -p 8080:8080 -p 27017:27017 tushar/zycus:v1
