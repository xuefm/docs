## 常用命令

### 帮助命令

```bash
docker version    #显示docker的版本信息。
docker info       #显示docker的系统信息，包括镜像和容器的数量
docker 命令 --help #帮助命令
```

### 镜像命令

```bash
docker pull ${CONTAINER NAME}                    #拉取镜像
docker images                                    #查看本地所有镜像
docker rmi ${IMAGE NAME/ID}                      #删除镜像
docker rmi -f ${IMAGE NAME/ID}                   #删除镜像
docker save ${IMAGE NAME} > ${FILE NAME}.tar     #将镜像保存成文件
docker load < ${FILE NAME}.tar                   #从文件加载镜像
```

### 容器命令

```bash
docker run...                                         #运行一个容器
    --name ${container name}                          #设置容器名称
    -p ${host port}:${container port}                 #映射主机和容器内的端口
    -e ${env name}=${env value}                       #添加环境变量
    -d                                                #后台运行
    -v ${host folder path}:${container folder path}   #将主机目录挂在到容器内
docker start ${CONTAINER NAME/ID}                     #运行一个以前运行过的容器
docker restart ${CONTAINER NAME/ID}                   #重启正在运行的容器
docker stop ${CONTAINER NAME/ID}                      #停止一个正在运行的容器
docker logs ${CONTAINER NAME/ID}                      #显示运行容器的日志
docker ps                                             #列出当前正在运行的容器
    -a, --all                                           #显示所有容器(默认显示正在运行)
    -n, --last int                                      #显示最近创建的容器(包括所有状态)(默认为-1)
    -q, --quiet                                         #只显示数字id
docker rm                                             #删除指定容器
docker start ${CONTAINER NAME/ID}                     #启动容器
docker restart ${CONTAINER NAME/ID}                   #重启容器
docker stop ${CONTAINER NAME/ID}                      #停止当前正在运行的容器
docker kill ${CONTAINER NAME/ID}                      #强制停止当前容器
```

##### 

### 查看日志

```bash
docker logs --help
#显示日志
-tf        #显示日志信息（一直更新）
--tail number #需要显示日志条数
docker logs -t --tail n 容器id #查看n行日志
docker logs -ft 容器id #跟着日志
```

### 进入容器

```bash
docker exec -it ${CONTAINER NAME/ID} /bin/bash                 #进入容器内
docker exec -it ${CONTAINER NAME/ID} ping ${CONTAINER NAME/ID} #一个容器ping另外一个容器
#推出当前容器
Ctrl+Q+P
```



## 高级命令

```bash
# Advance use 
docker inspect ${CONTAINER NAME/ID}                            #显示容器详细信息
docker ps -f "status=exited"                                   #显示所有退出的容器
docker ps -a -q                                                #显示所有容器id
docker ps -f "status=exited" -q                                #显示所有退出容器的id
docker restart $(docker ps -q)                                 #重启所有正在运行的容器
docker stop $(docker ps -a -q)                                 #停止所有容器
docker rm $(docker ps -a -q)                                   #删除所有容器
docker rm $(docker ps -f "status=exited" -q)                   #删除所有退出的容器
docker rm $(docker stop $(docker ps -a -q))                    #停止并删除所有容器
docker start $(docker ps -a -q)                                #启动所有容器
docker rmi $(docker images -a -q)                              #删除所有镜像
docker top ${CONTAINER NAME/ID}                                #显示一个容器的top信息
docker stats                                                   #显示容器统计信息(正在运行)
	docker stats -a                                            #显示所有容器的统计信息(包括没有运行的)
	docker stats -a --no-stream                                #显示所有容器的统计信息(包括没有运行的) ，只显示一次
    docker stats --no-stream | sort -k8 -h                     #统计容器信息并以使用流量作为倒序
docker system 
	docker system df           #显示硬盘占用
    docker system events       #显示容器的实时事件
    docker system info         #显示系统信息
    docker system prune        #清理文件
```