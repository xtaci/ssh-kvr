#!/bin/bash

IPADDR=$(ip addr show dev eth0|grep inet|tail -n 1|awk '{print $2}'|cut -d / -f1)
DISKUSAGE=$(df -ah /storage/ |tail -n 1|awk '{printf("%s %s %s",$2,$3,$4)}') 

echo $IPADDR $DISKUSAGE
