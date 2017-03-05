#!/usr/bin/env python
import sys
import paramiko
import argparse
import socket

parser = argparse.ArgumentParser()
parser.add_argument("-s", "--servername", help="hostname", required=True)
parser.add_argument("-P", "--port", help="ssh port", default=22)
parser.add_argument("-t", "--sudo", help="enable sudo",action='store_true')
parser.add_argument("-u","--username",help="username",required=True)
parser.add_argument("-k", "--keyfile", help="Path of private key file")
parser.add_argument("cmd",help="command to run")
args=parser.parse_args()
 
host = args.servername
port = args.port
user = args.username 
key = args.keyfile
cmd = args.cmd
if args.sudo:
    fullcmd="echo " + password + " |   sudo -S -p '' " + cmd
else:
    fullcmd=cmd
 
#if __name__ == "__main__":
client = paramiko.SSHClient()

#Don't use host key auto add policy for production servers
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
client.load_system_host_keys()
try: 
    client.connect(host,port,user,key)
    transport=client.get_transport()
except (socket.error,paramiko.AuthenticationException) as message:
    print "ERROR: SSH connection to "+host+" failed: " +str(message)
    sys.exit(1)
session=transport.open_session()
session.set_combine_stderr(True)
if args.sudo: 
    session.get_pty()
session.exec_command(fullcmd)
stdout = session.makefile('rb', -1)
print stdout.read()
transport.close()
client.close() 
