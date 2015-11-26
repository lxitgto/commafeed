FROM ubuntu:14.04

RUN apt-get install -y add-apt-repository && add-apt-repository ppa:openjdk-r/ppa && apt-get update && apt-get install -y git vim g++ build-essential openjdk-8-jdk maven \
&& update-alternatives --config java \
&& update-alternatives --config javac \
&& mkdir /commafeed && mkdir /config && mkdir /data
WORKDIR /commafeed

ENV COMMAFEED_GIT https://github.com/Athou/commafeed.git
ENV COMMAFEED_VERSION 2.2.0

RUN git clone $COMMAFEED_GIT . && git checkout $COMMAFEED_VERSION && mvn clean package && cp /commafeed/config.dev.yml /config/config.yml

VOLUME /config
VOLUME /data

WORKDIR /data
ENTRYPOINT java -jar /commafeed/target/commafeed.jar server /config/config.yml
