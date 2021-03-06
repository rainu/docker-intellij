FROM openjdk:8-jdk
MAINTAINER rainu <rainu@raysha.de>

ENV INTELLIJ_LINK http://download.jetbrains.com/idea/ideaIU-2017.1.2.tar.gz
ENV GOLANG http://storage.googleapis.com/golang/go1.8.linux-amd64.tar.gz

ENV USERNAME intellij
ENV GROUPNAME intellij

#make home directory for intellij user
RUN mkdir -p /home/intellij && \
    mkdir -p /home/intellij/.m2

#download and extract intelliJ-Ultimate
RUN wget -nv $INTELLIJ_LINK -O /tmp/intellij.tar.gz &&\
	tar -xzvf /tmp/intellij.tar.gz -C /opt/ && mv /opt/$(ls /opt/) /opt/intellij/ &&\
	rm /tmp/intellij.tar.gz &&\
	rm -rf /opt/intellij/jre64 && ln -s $JAVA_HOME/jre /opt/intellij/jre64

#download and extract golang
RUN wget -nv $GOLANG -O /tmp/golang.tar.gz &&\
	tar -xzvf /tmp/golang.tar.gz -C /usr/local/ &&\
  rm /tmp/golang.tar.gz

COPY ./start.sh /home/intellij/start.sh

ENTRYPOINT ["/home/intellij/start.sh"]
