# 准备文件

 jdk-11.0.11_linux-x64_bin.tar.gz           如果版本不一样请修改Dockerfile中的jdk版本

Dockerfile

# 1.新建Dockerfile

```tex
FROM centos
MAINTAINER expect< 321766987@qq. com>

ADD jdk-11.0.11_linux-x64_bin.tar.gz /usr/local/

RUN yum -y install vim
RUN cd /opt
RUN mkdir java
ENV MYPATH /opt/java
WORKDIR $MYPATH

ENV TZ=Asia/Shanghai
ENV JAVA_HOME /usr/local/jdk-11.0.11
ENV CLASSPATH $JAVA_HOME/lib/dt.jar :$JAVA_ HOME/lib/tools.jar
ENV PATH $PATH:$JAVA_HOME/bin
EXPOSE 8080

ENTRYPOINT ["java","-Duser.timezone=GMT+8","-Dfile.encoding=UTF-8","-Dsun.jnu.encoding=UTF-8","-jar","/opt/java/app.jar"]

```

## 通过DockerFile构建镜像

```bash
 docker build -t java:11 .
```

注意 后面的 . 不能省略

## 查看构建的镜像

```bash
docker imags
```

## 创建容器

```bash
docker run --name java -d -p 8080:8080 -v /opt/java/app.jar:/opt/java/app.jar java:11
```

## 创建容器指定网络

```bash
docker run --name java -d -p 8080:8080 -v /opt/java/app.jar:/opt/java/app.jar --network expect java:11
```

## 查看日志

```bash
docker logs -f --tail 200 java
```



