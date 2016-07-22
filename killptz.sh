#!/bin/bash
PIDtoKILL=$(cat /tmp/ptz.pid)
kill -9 $PIDtoKILL
echo "***********Monitoramento parado!***********" >> /var/log/syslog
sleep 1
rm -f /tmp/ptz.pid
exit 0
