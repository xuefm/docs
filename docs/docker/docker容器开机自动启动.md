部署项目服务器时，为了应对停电等情况影响正常web项目的访问，会把Docker容器设置为开机自动启动。

在使用docker run启动容器时，使用--restart参数来设置：

```bash
docker run -m 512m --memory-swap 1G -it -p 58080:8080 --restart=always 
# --name bvrfis --volumes-from logdata mytomcat:4.0 /root/run.sh
```

**--restart**具体参数值详细信息：

**no** - 容器退出时，不重启容器；

**on-failure** - 只有在非0状态退出时才从新启动容器；

**always** - 无论退出状态是如何，都重启容器；


还可以在使用on - failure策略时，指定Docker将尝试重新启动容器的最大次数。默认情况下，Docker将尝试永远重新启动容器。

```bash
docker run --restart=on-failure:10 redis
```

如果创建时未指定 --restart=always ,可通过update 命令

```bash
docker update --restart=always xxx
```

-–restart参数

```bash
-–restart参数有三个可选值：no,on-failure,always

no为默认值，表示容器退出时，docker不自动重启容器
on-failure表示，若容器的退出状态非0，则docker自动重启容器，还可以指定重启次数，若超过指定次数未能启动容器则放弃
docker update --restart=on-failure:3 [容器名]

always表示只要容器退出，则docker将自动重启容器
1.docker容器运行时设置
#docker服务重启后容器会自动重启
docker run ****** --restart=always

2.docker容器已经启动了，则可以通过如下命令设置
docker update --restart=always <Container ID>

Warning: The docker update and docker container update commands are not supported for Windows containers.

官方网站说不支持windows容器上使用docker update命令，经实际测试windows上使用此命令一样可以起作用。


```

