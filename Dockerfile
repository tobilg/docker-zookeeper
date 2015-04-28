FROM java:openjdk-7-jre
MAINTAINER tobilg <fb.tools.github@gmail.com>

RUN apt-get update && apt-get install -y wget
RUN wget -q -O - http://www.eu.apache.org/dist/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz | tar -xzf - -C /opt \
    && mv /opt/zookeeper-3.4.6 /opt/zookeeper \
    && mkdir -p /var/log/zookeeper \
    && mkdir -p /var/lib/zookeeper

#RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ADD bootstrap.sh /usr/local/bin/bootstrap.sh

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper

VOLUME ["/opt/zookeeper/conf", "/var/log/zookeeper"]

#RUN /bin/bash -c "source /usr/local/bin/bootstrap.sh"

ENTRYPOINT ["/usr/local/bin/bootstrap.sh"]
CMD ["start-foreground"]