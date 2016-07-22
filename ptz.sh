#!/bin/bash
PIDtoKILL=$(cat /tmp/ptz.pid)
kill -9 $PIDtoKILL
echo "***********Monitoramento parado!***********" >> /var/log/syslog
sleep 1
rm -f /tmp/ptz.pid
exit 0
root@zoneminder:/var/www/html/images# cat /etc/ptz.sh
#!/bin/bash

echo $$ > /tmp/ptz.pid
DIR="/var/www/html/images"
HOJE=$(date +"%Y-%m-%d")

# Inicializa, voltando para o meio (Café)
curl -s 'http://143.54.235.92:8088/decoder_control.cgi?command=31&user=admin&pwd=rapadura'
sleep 2.5

while true; do
	if [ ! -d "$DIR/$HOJE" ]; then
		mkdir -p $DIR/$HOJE
	fi
# Vai para o TRI
curl -s 'http://143.54.235.92:8088/decoder_control.cgi?command=33&user=admin&pwd=rapadura'
sleep 2.5
for (( i=1; i <= 10; i++ ))
do
curl -s -o $DIR/$HOJE/tri_$(date +"%Y%m%d-%H%M")-$i.jpg 'http://143.54.235.92:8088/snapshot.cgi?user=admin&pwd=rapadura&count=1'
sleep 0.3
done
sleep 1
# Vai para o café
curl -s 'http://143.54.235.92:8088/decoder_control.cgi?command=31&user=admin&pwd=rapadura'
sleep 2.5
for (( i=1; i <= 10; i++ ))
do
curl -s -o $DIR/$HOJE/dim_$(date +"%Y%m%d-%H%M")-$i.jpg 'http://143.54.235.92:8088/snapshot.cgi?user=admin&pwd=rapadura&count=1'
sleep 0.3
done
sleep 1
done
