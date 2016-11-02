#!/bin/bash 
# purpose: check for expected amount of consul server to go "alive", then drops bootstrap mode from consul deamon
# date:  Nov,1,2016
# authors: tonynv@amazon.com

CONSUL_EXPECT=__CONSUL_EXPECT__
SERVERS_READY=0

#Run node scaner
while [[ $SERVERS_READY  -lt $CONSUL_EXPECT ]]; 
	do   
		echo "READY SERVERS = $SERVERS_READY" >>/tmp/check.log  
		SERVERS_READY=$(consul  members  info | grep server | grep alive   | wc -l); sleep 3
	done
# Kill consul seed
echo "Scanner exited with $?" >>/tmp/check.log
if [[ $SERVERS_READY  -eq $CONSUL_EXPECT  ]];
then
echo "Check [PASS]" >>/tmp/check.log
echo "SERVERS_READY = ${SERVERS_READY}"  >>/tmp/check.log
echo "CONSUL_EXPECT = ${CONSUL_EXPECT}"  >>/tmp/check.log

# Restart with out bootstrap_expect
sudo /bin/bash -c '/usr/bin/killall -q consul; sleep 5; exit 0' 
sudo start consul
echo "Completed (consul started in  non-bootstrap mode)..." >>/tmp/check.log

else
echo "Check [FAILED]" >>/tmp/check.log
echo "SERVERS_READY =${SERVERS_READY}" >>/tmp/check.log 
echo "CONSUL_EXPECT =${CONSUL_EXPECT}" >>/tmp/check.log
  exit 1
fi
