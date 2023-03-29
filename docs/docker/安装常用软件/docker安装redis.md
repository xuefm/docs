参考网址https://www.cnblogs.com/yanglei-xyz/p/10813175.html

#### 拉取redis镜像

```bash
docker pull redis
```

#### 本地新建redis配置文件 **redis.conf** ，写入以下内容

```tex
#允许外网访问
bind 0.0.0.0
daemonize NO
protected-mode no
requirepass 123456
```

#### 运行容器run

```bash
docker run \
--name redis \
--restart always \
--network expect \
-p 6379:6379 \
-v /root/redis/redis.conf:/etc/redis/redis.conf \
-v /root/redis/data/data:/data \
-d \
redis redis-server /etc/redis/redis.conf\
 --appendonly yes 

 
```

```bash
 #根据自己的情况 编写 --name  和-v
 docker run \
--name {容器名} \			#容器名
--restart always \ #设置开机自启动
--network {网卡名称} \ #指定网卡(若不需要则可取消此参数)
-p {本机端口}:6379 \		#端口映射
-v /{本机redis.conf路径}/redis.conf:/etc/redis/redis.conf \ #挂载redis.conf
-v /{本机redisData路径}/data/data:/data \  #挂载data目录
-d \						#后台运行
redis redis-server /etc/redis/redis.conf\  
 --appendonly yes
```



命令说明：

**-p 10001:6379 :** 将容器的6379端口映射到主机的10001端口

**--name redis :** 容器名字

**--restart always ：**自动启动容器

**-v /data/redis/redis.conf:/etc/redis/redis.conf :** 将主机中配置文件挂载到容器中

**-v /data/redis/data:/data :** 将主机中data挂载到容器的/data

**redis-server --appendonly yes :** 在容器执行redis-server启动命令，并打开redis持久化配置

**redis-server /etc/redis/redis.conf :** 容器中以配置文件方式启动redis



如果创建时未指定 --restart=always ,可通过update 命令

```bash
docker update --restart=always xxx
```

