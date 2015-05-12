#!/bin/bash

printf "{\"data\":["

for config in `ls /etc/memcached/*`; do
	. ${config} 
	printf "{\"{#IP_ADDR}\":\"%s\",\"{#PORT}\":\"%s\"}," ${IP_ADDR} ${PORT}
done

printf "]}"
