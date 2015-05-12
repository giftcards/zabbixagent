#!/bin/bash 
###############################
##      ** Do Not Modify **
##  Automatically Generated File
##
#################################

BASEETH=`/sbin/ifconfig | head -1 | awk '{print $1;}'`
BASEIP=`/sbin/ifconfig $BASEETH | grep 'inet addr:' | cut -d: -f2 | awk '{print $1;}'`
exec 3<>/dev/tcp/$BASEIP/80 && echo -e 'GET /server-status?auto\n' >&3
REQUEST=$1

if [ "$REQUEST" == "accesses" ]; then cat <&3 | grep 'Total Accesses:' | awk '{print $3;}'; fi
if [ "$REQUEST" == "kbytes" ]; then cat <&3 | grep 'Total kBytes:' | awk '{print $3;}'; fi
if [ "$REQUEST" == "uptime" ]; then cat <&3 | grep 'Uptime:' | awk '{print $2;}'; fi
if [ "$REQUEST" == "reqpersec" ]; then cat <&3 | grep 'ReqPerSec:' | awk '{print $2;}'; fi
if [ "$REQUEST" == "bytespersec" ]; then cat <&3 | grep 'BytesPerSec:' | awk '{print $2;}'; fi
if [ "$REQUEST" == "bytesperreq" ]; then cat <&3 | grep 'BytesPerReq:' | awk '{print $2;}'; fi
if [ "$REQUEST" == "busyworkers" ]; then cat <&3 | grep 'BusyWorkers:' | awk '{print $2;}'; fi
if [ "$REQUEST" == "idleworkers" ]; then cat <&3 | grep 'IdleWorkers:' | awk '{print $2;}'; fi
if [ "$REQUEST" == "cpuload" ]; then cat <&3 | grep 'CPULoad:' | awk '{print $2;}'; fi
if [ "$REQUEST" == "isrunning" ]; then
        if [ "`ps -ef | grep httpd | grep ^root`" ]; then echo "1"; else echo "0"; fi
fi
if [ "$REQUEST" == "s.wait" ]; then cat <&3 | grep 'Scoreboard:' | awk '{print $2;}' | fgrep -o _ | wc -l; fi
if [ "$REQUEST" == "s.start" ]; then cat <&3 | grep 'Scoreboard:' | awk '{print $2;}' | fgrep -o S | wc -l; fi
if [ "$REQUEST" == "s.read" ]; then cat <&3 | grep 'Scoreboard:' | awk '{print $2;}' | fgrep -o R | wc -l; fi
if [ "$REQUEST" == "s.sendrep" ]; then cat <&3 | grep 'Scoreboard:' | awk '{print $2;}' | fgrep -o W | wc -l; fi
if [ "$REQUEST" == "s.keep" ]; then cat <&3 | grep 'Scoreboard:' | awk '{print $2;}' | fgrep -o K | wc -l; fi
if [ "$REQUEST" == "s.dns" ]; then cat <&3 | grep 'Scoreboard:' | awk '{print $2;}' | fgrep -o D | wc -l; fi
if [ "$REQUEST" == "s.close" ]; then cat <&3 | grep 'Scoreboard:' | awk '{print $2;}' | fgrep -o C | wc -l; fi
if [ "$REQUEST" == "s.log" ]; then cat <&3 | grep 'Scoreboard:' | awk '{print $2;}' | fgrep -o L | wc -l; fi
if [ "$REQUEST" == "s.grace" ]; then cat <&3 | grep 'Scoreboard:' | awk '{print $2;}' | fgrep -o G | wc -l; fi
if [ "$REQUEST" == "s.idle" ]; then cat <&3 | grep 'Scoreboard:' | awk '{print $2;}' | fgrep -o I | wc -l; fi
if [ "$REQUEST" == "s.open" ]; then cat <&3 | grep 'Scoreboard:' | awk '{print $2;}' | fgrep -o . | wc -l; fi

if [ "$REQUEST" == "dump" ]; then cat <&3; fi
