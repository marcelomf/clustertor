#!/bin/bash
port=$1
cat << EOF >sendcmd$port
AUTHENTICATE "torcluster_change123"
signal NEWNYM
quit
\r\n
EOF
cat sendcmd$port | netcat localhost $port > /dev/null 2>&1
