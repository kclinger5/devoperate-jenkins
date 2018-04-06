#!/bin/bash

# Add hostname to primary network device IP in /etc/hosts.

echo “Adding myhost.example.com to /etc/hosts.”

NUMDEVS=$(cat /proc/net/dev | awk '{print $1,$2 }' | wc -l)

OUTDEV=$(cat /proc/net/dev| awk '{print $1, $2}'| tail -$(expr $NUMDEVS - 2)| sort -k 2 -nr| cut -d: -f1| head -1)

OUTIP=$(ip a | grep $OUTDEV | grep inet | awk '{print $2}' | cut -d/ -f1)

read -p 'What is your machines hostname? ' MYHOSTNAME

echo "$OUTIP $MYHOSTNAME" >> /etc/hosts
