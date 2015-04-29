#!/bin/bash
touch iplist
port=$1
control_port=$2
if test "$MODE" = "proxy";
then
  echo "Proxy mode, please enter into container and startup privoxy, squid, haproxy etc"
  exit 0
fi

cat /etc/torrc > torrc$port\.conf
echo "SocksPort 0.0.0.0:$port" >> torrc$port\.conf
#  echo "StrictNodes 1" >> torrc$port\.conf
#  echo "ExitNodes {br},{us},{ca},{de},{fr},{ar},{uk},{it}" >> torrc$port\.conf
#  /usr/local/bin/tor -f torrc$port\.conf >/dev/null &
/usr/local/bin/tor --CookieAuthentication 0 --HashedControlPassword "16:34FFBE09AE7E3EE260AB060B45F0E2CFAFB61F0FCBBAD47BC313FA2E29" --ControlPort $control_port --PidFile tor$port\.pid --SocksPort $port -f torrc$port\.conf >tor$port\.log
sleep 3
while true; do
  ./tornewid.sh $control_port #expect tornewid.exp $control_port
  sleep 2
  rm -rf cookie_$port\.jar
  IP=$(curl --socks5 0.0.0.0:$port -sSL http://www.telize.com/ip)
  echo "IP":$IP
  grep "$IP" iplist > /dev/null 2>&1
  if [ $? -eq 0 ]; then
#  if test "$IP" = "$LASTIP"; then
    echo "IP IGUAL"
#   kill -9 $(pidof tor) > /dev/null 2>&1 #kill -USR1 $(netstat -nap | grep 0.0.0.0:$port | cut -d'/' -f1 | cut -d' ' -f49)
    continue
  fi
  echo "$IP" >> iplist
  LASTIP=$IP
  curl --socks5 0.0.0.0:$port -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/534.30 (KHTML, like Gecko).0.742.112 Safari/534.30" -sSL http://www.sitealvo.com.br/subdir -c cookie_$port\.jar > /dev/null 
  grep sitealvo.com.br cookie_$port\.jar > /dev/null
  if [ $? -ne 0 ]; then
    echo "false0"
    #kill -9 $(pidof tor) > /dev/null 2>&1 #kill -USR1 $(netstat -nap | grep 0.0.0.0:$port | cut -d'/' -f1 | cut -d' ' -f49)
    continue
    exit 1
  fi
  resposta=$(curl --socks5 0.0.0.0:$port -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/534.30 (KHTML, like Gecko)me/12.0.742.112 Safari/534.30" -sSL http://www.sitealvo.com.br/wp-admin/votacao.php?id=158990 -b cookie_$port\.jar)
  if test "$resposta" = "true"; then
    echo $resposta
#    kill -9 $(pidof tor) > /dev/null 2>&1 #kill -USR1 $(netstat -nap | grep 0.0.0.0:$port | cut -d'/' -f1 | cut -d' ' -f49)
    continue
    exit 0
  fi
  #echo $resposta
  echo "false1"
#  kill -9 $(pidof tor) > /dev/null 2>&1 #kill -USR1 $(netstat -nap | grep 0.0.0.0:$port | cut -d'/' -f1 | cut -d' ' -f49)
  continue
  exit 1
done
