#!/bin/bash

echo "tickTime=2000" > /opt/zookeeper/conf/zoo.cfg
echo "dataDir=/var/lib/zookeeper" >> /opt/zookeeper/conf/zoo.cfg
echo "dataLogDir=/var/log/zookeeper" >> /opt/zookeeper/conf/zoo.cfg
echo "clientPort=2181" >> /opt/zookeeper/conf/zoo.cfg
echo "initLimit=90" >> /opt/zookeeper/conf/zoo.cfg
echo "syncLimit=30" >> /opt/zookeeper/conf/zoo.cfg

if [ -n "${ZOOKEEPER_HOSTS+1}" ]; then
  IFS=',' read -a zhosts <<< "$ZOOKEEPER_HOSTS"
  for index in "${!zhosts[@]}"
  do
    echo "server.$((index+1))=${zhosts[index]}"  >> /opt/zookeeper/conf/zoo.cfg
  done
fi

if [ -n "${ZOOKEEPER_ID+1}" ]; then
  echo $ZOOKEEPER_ID > /var/lib/zookeeper/myid
else
  for index in "${!zhosts[@]}"
  do
    if [[ "${zhosts[index]}" =~ "$LOCAL_ZK_IP" ]]; then
      echo "$((index+1))" > /var/lib/zookeeper/myid
    fi
  done
fi

exec /opt/zookeeper/bin/zkServer.sh $1