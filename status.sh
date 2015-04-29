#!/bin/bash
echo "Total requests:"
for dock in $(docker ps -a | cut -d ' ' -f1 | grep -v CONTAINER | xargs echo); do docker logs $dock; done | grep IP | cut -d'>' -f3 | sort | wc -l
echo "Total IPs unicos:"
for dock in $(docker ps -a | cut -d ' ' -f1 | grep -v CONTAINER | xargs echo); do docker logs $dock; done | grep IP | cut -d'>' -f3 | sort | uniq | wc -l
echo "Total requests ok:"
#for dock in $(docker ps -a | cut -d ' ' -f1 | grep -v CONTAINER | xargs echo); do docker logs $dock | grep true | wc -l; done
for dock in $(docker ps -a | cut -d ' ' -f1 | grep -v CONTAINER | xargs echo); do docker logs $dock; done | grep true | wc -l
