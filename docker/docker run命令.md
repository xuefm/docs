### docker run常用命令

docker run :创建一个新的容器并运行一个命令

```bash
语法：docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
```



#### 1.OPTIONS说明

```bash
-t:为容器重新分配一个伪输入终端，通常与 -i 同时使用
-i:以交互模式运行容器，通常与 -t 同时使用
-d:后台运行容器，并返回容器ID
--name:为容器指定一个名称
-p:端口映射，格式为：主机(宿主)端口:容器端口
-v:	挂载宿主机文件夹，格式为： 宿主机文件夹：容器文件夹
--link: 添加链接到另一个容器
-m:设置容器使用内存最大值；
```

#### 2.使用docker镜像tomcat:latest以后台模式启动一个容器,并将容器命名为mytomcat

```bash
docker run -tid --name mytomcat tomcat:latest
```

#### 3.使用镜像tomcat:latest以后台模式启动一个容器,并将容器的8080端口映射到宿主机的8080端口。

```bash
docker run -tid --name mytomcat -p 8080:8080 tomcat:latest
```

#### 4.使用镜像tomcat:latest以后台模式启动一个容器,并将容器的8080端口映射到宿主机的8080端口,主机的目录 /home 映射到容器的 /home

```bash
docker run -tid --name mytomcat -p 8080:8080 -v /home:/home tomcat:latest
```

#### 5.使用镜像tomcat:latest启动一个容器,在容器内执行/bin/bash命令。

```bash
docker run -it tomcat:latest /bin/bash
```

