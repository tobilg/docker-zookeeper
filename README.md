#Zookeeper 3.4.6

This Docker image is running a Zookeeper 3.4.6 server. It can be cluster-enabled by passing an environment variable `ZOOKEEPER_HOSTS` with a list of comma-separated hosts:

    192.168.0.1:2888:3888,192.168.0.2:2888:3888,192.168.0.3:2888:3888

e.g. if you want to run different Zookeeper instances on different Docker hosts. Be sure expose the relevant ports (`2181`, `2888` and `3888`).

## Configuration

To run a "plain" Zookeper instance without cluster support, the image can be started with 

    $ docker run -d \
        --name zookeeper \
        --net=host \
        -p 2181:2181 \
        -p 2888:2888 \
        -p 3888:3888 \
        tobilg/zookeeper

If you want to dynmically configure a cluster, the image can be run with (Debian/Ubuntu-based hosts)

    $ docker run -d \
        --name zookeeper \
        --net=host \
        -e ZOOKEEPER_HOSTS=192.168.0.1:2888:3888,192.168.0.2:2888:3888,192.168.0.3:2888:3888 \
        -e LOCAL_ZK_IP=$(/usr/bin/ip -o -4 addr list eth0 | grep global | awk '{print $4}' | cut -d: -f1) \
        -p 2181:2181 \
        -p 2888:2888 \
        -p 3888:3888 \
        tobilg/zookeeper

RedHat/CentOS/Fedora-based hosts' `LOCAL_ZK_IP` line need to replaced with

    -e LOCAL_ZK_IP=$(/sbin/ifconfig eth0 | grep 'inet ' | awk '{print $2}') \

The `LOCAL_ZK_IP` must be provided to be matched to the hosts contained in `ZOOKEEPER_HOSTS` for the generation of the `myid` file (see [Zookeeper docs](http://zookeeper.apache.org/doc/trunk/zookeeperStarted.html#sc_RunningReplicatedZooKeeper)).
Be sure to replace `eth0` with the "public" network interface.