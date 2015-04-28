FROM java:openjdk-7-jre
MAINTAINER tobilg <fb.tools.github@gmail.com>

RUN apt-get update && apt-get install -y wget
RUN wget -q -O - http://www.eu.apache.org/dist/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz | tar -xzf - -C /opt
RUN mv /opt/zookeeper-3.4.6 /opt/zookeeper
RUN mkdir -p /var/log/zookeeper
RUN mkdir -p /var/lib/zookeeper

ADD bootstrap.sh /usr/local/bin/bootstrap.sh

RUN chmod +x /usr/local/bin/bootstrap.sh

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper

ENTRYPOINT ["/usr/local/bin/bootstrap.sh"]
CMD ["start-foreground"]