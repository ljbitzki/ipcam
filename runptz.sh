#!/bin/bash
if [ -f /tmp/ptz.pid ]; then
PID=$(cat /tmp/ptz.pid)
wait
bash /etc/killptz.sh &
echo "Já há um processo rodando... aguardando o PID $PID morrer..."
sleep 1
else
echo "Abrindo o monitoramento!"
bash /etc/ptz.sh &
fi
echo "Feito!"
exit 0
