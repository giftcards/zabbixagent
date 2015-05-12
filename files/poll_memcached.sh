#!/bin/bash 

exec 3<>/dev/tcp/${1}/${2} && echo -e 'stats\nstats items\nstats slabs\nquit\n' >&3
REQUEST=${3}

cat <&3 | grep "\s${REQUEST}\s" | awk '{print $3}'
