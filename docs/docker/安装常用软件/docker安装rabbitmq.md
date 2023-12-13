## 一 下载镜像

拉取镜像

```bash
docker pull rabbitmq
```

查看所有镜像

```bash
docker images
```

## 二、安装和web界面启动

镜像创建和启动容器

```bash
docker run -d --name rabbitmq -p 5672:5672 -p 15672:15672 -v `pwd`/data:/var/lib/rabbitmq --hostname myRabbit -e RABBITMQ_DEFAULT_VHOST=my_vhost  -e RABBITMQ_DEFAULT_USER=admin -e RABBITMQ_DEFAULT_PASS=admin rabbitmq
```

说明：

- -d 后台运行容器；
- --name 指定容器名；
- -p 指定服务运行的端口（5672：应用访问端口；15672：控制台Web端口号）；
- -v 映射目录或文件；
- --hostname 主机名（RabbitMQ的一个重要注意事项是它根据所谓的 “节点名称” 存储数据，默认为主机名）；
- -e 指定环境变量；（RABBITMQ_DEFAULT_VHOST：默认虚拟机名；RABBITMQ_DEFAULT_USER：默认的用户名；RABBITMQ_DEFAULT_PASS：默认用户名的密码）

查看正在运行容器

```bash
docker ps
```

启动rabbitmq_management

```bash
docker exec -it rabbitmq rabbitmq-plugins enable rabbitmq_management
```

rabbit 为镜像的应用名称

开启防火墙15672端口

```bash
 firewall-cmd --zone=public --add-port=15672/tcp --permanent　　　　　　　　

 firewall-cmd --reload 
```

浏览器打开web管理端：[http://ip:15672](http://ip:15672/)

