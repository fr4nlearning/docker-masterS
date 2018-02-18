#!/bin/bash
ssh-keyscan nodo >> ~/.ssh/known_hosts
sshpass -p 'root' ssh-copy-id -i ~/.ssh/id_rsa.pub root@nodo

echo "nodo" >> /opt/spark/conf/slaves

cp /opt/spark/conf/spark-env.sh.template /opt/spark/conf/spark-env.sh
echo "export SPARK_MASTER_HOST=master" >> /opt/spark/conf/spark-env.sh
echo "export SPARK_WORKER_CORES=1" >> /opt/spark/conf/spark-env.sh
echo "export SPARK_WORKER_MEMORY=1024" >> /opt/spark/conf/spark-env.sh
echo "export SPARK_WORKER_INSTANCES=1" >> /opt/spark/conf/spark-env.sh

cp /opt/livy/conf/livy.conf.template /opt/livy/conf/livy.conf
echo "livy.spark.master=spark://master:7077" >> /opt/livy/conf/livy.conf
echo "livy.spark.deploy-mode=client" >> /opt/livy/conf/livy.conf

start-all.sh

livy-server start

tail -f /dev/null
