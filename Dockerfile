FROM debian:wheezy

RUN apt-get update && apt-get install -y git vim && mkdir /commafeed && mkdir /config && mkdir /data
WORKDIR /commafeed

RUN apt-get install -y build-essential openjdk-7-jdk maven

ENV COMMAFEED_GIT https://github.com/Athou/commafeed.git
ENV COMMAFEED_VERSION 2.1.0

RUN git clone $COMMAFEED_GIT . && git checkout $COMMAFEED_VERSION && mvn clean package && cp /commafeed/config.dev.yml /config/config.yml

VOLUME /config
VOLUME /data

WORKDIR /data
ENTRYPOINT java -jar /commafeed/target/commafeed.jar server /config/config.yml
