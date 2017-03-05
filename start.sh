#!/bin/bash
#
# SCRIPT:	start.sh
#
# AUTHOR:	Tushar Dwivedi
#
# DATE:		02-09-2017
#
# REV:		0.1.A
#
# PLATFORM:	Linux, UNIX, MAC OS
#
# PURPOSE:	This Script will start tomcat and mongodb. 
#
# set -x	# Uncomment to debug the shell script.
#

/opt/tomcat7/bin/catalina.sh run & /usr/bin/mongod
