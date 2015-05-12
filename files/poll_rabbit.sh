#!/bin/bash
[ `whoami` != 'root' ] && [ `whoami` != 'rabbitmq' ] && echo "You must be the root or rabbitmq user." && exit

IFS='
'


if [[ -z "$1" ]]; then
	printf "{\"data\":["
	/usr/sbin/rabbitmqctl list_queues | grep -v "amq\.gen" | grep -v "\.\.\." | awk '{print "{\"{#QUEUE}\":\"" $1 "\"},"}' | sed -e "$ s/,/]}/g" | sed ':a;N;$!ba;s/\n//g'
else
	OUTPUT=`/usr/sbin/rabbitmqctl list_queues | grep -v "\.\.\." | grep "^$1\s" | awk '{print $2}'`
	[[ -z "$OUTPUT" ]] && echo "ZBX_UNSUPPORTED" || echo ${OUTPUT}
fi
