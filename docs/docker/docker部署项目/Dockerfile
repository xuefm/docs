FROM centos
MAINTAINER expect< 321766987@qq. com>

ADD openjdk-17+35_linux-x64_bin.tar.gz /usr/local/

RUN cd /opt
RUN mkdir java
ENV MYPATH /opt/java
WORKDIR $MYPATH

ENV TZ=Asia/Shanghai
ENV JAVA_HOME /usr/local/jdk-17
ENV CLASSPATH $JAVA_HOME/lib/dt.jar :$JAVA_ HOME/lib/tools.jar
ENV PATH $PATH:$JAVA_HOME/bin
EXPOSE 8080

ENTRYPOINT ["java","-Duser.timezone=GMT+8","-Dfile.encoding=UTF-8","-Dsun.jnu.encoding=UTF-8","-jar","/opt/java/app.jar"]
