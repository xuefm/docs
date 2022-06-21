### Docker概述

##### Docker为什么出现？

一款产品： 开发–上线 两套环境！应用环境，应用配置！

开发 — 运维。 问题：我在我的电脑上可以允许！版本更新，导致服务不可用！对于运维来说考验十分大？

环境配置是十分的麻烦，每一个及其都要部署环境(集群Redis、ES、Hadoop…) !费事费力。

发布一个项目( jar + (Redis MySQL JDK ES) ),项目能不能带上环境安装打包！

之前在服务器配置一个应用的环境 Redis MySQL JDK ES Hadoop 配置超麻烦了，不能够跨平台。

开发环境Windows，最后发布到Linux！

传统：开发jar，运维来做！

现在：开发打包部署上线，一套流程做完！

安卓流程：java — apk —发布（应用商店）一 张三使用apk一安装即可用！

docker流程： java-jar（环境） — 打包项目帯上环境（镜像） — ( Docker仓库：商店）——-

Docker给以上的问题，提出了解决方案！

Docker的思想就来自于集装箱！

JRE – 多个应用(端口冲突) – 原来都是交叉的！
隔离：Docker核心思想！打包装箱！每个箱子是互相隔离的。

Docker通过隔离机制，可以将服务器利用到极致！

##### Docker历史

2010年，几个的年轻人，就在美国成立了一家公司 dotcloud

做一些pass的云计算服务！LXC（Linux Container容器）有关的容器技术！

> Linux Container容器是一种内核虚拟化技术，可以提供轻量级的虚拟化，以便隔离进程和资源。

他们将自己的技术（容器化技术）命名就是 Docker
Docker刚刚延生的时候，没有引起行业的注意！dotCloud，就活不下去！

2013年，Docker开源！

越来越多的人发现docker的优点！火了。Docker每个月都会更新一个版本！

2014年4月9日，Docker1.0发布！

docker为什么这么火？十分的轻巧！

在容器技术出来之前，我们都是使用虚拟机技术！

虚拟机：在window中装一个VMware，通过这个软件我们可以虚拟出来一台或者多台电脑！笨重！

虚拟机也属于虚拟化技术，Docker容器技术，也是一种虚拟化技术！

> vm : linux centos 原生镜像（一个电脑！） 隔离、需要开启多个虚拟机！ 几个G 几分钟
> docker: 隔离，镜像（最核心的环境 4m + jdk + mysql）十分的小巧，运行镜像就可以了！小巧！ 几个M 秒级启动！

Docker基于Go语言开发的！开源项目！

##### Docker能干嘛

之前的虚拟机技术！
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210413163931187.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDIzNTUzMg==,size_16,color_FFFFFF,t_70)
虚拟机技术缺点：

1、 资源占用十分多

2、 冗余步骤多

3、 启动很慢！

**容器化技术**
容器化技术不是模拟一个完整的操作系统
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210413164006619.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDIzNTUzMg==,size_16,color_FFFFFF,t_70)
比较Docker和虚拟机技术的不同：

1 .传统虚拟机，虚拟出一条硬件，运行一个完整的操作系统，然后在这个系统上安装和运行软件
2 .容器内的应用直接运行在宿主机的内容，容器是没有自己的内核的，也没有虚拟我们的硬件，所以就轻便了
3 .每个容器间是互相隔离，每个容器内都有一个属于自己的文件系统，互不影响
应用更快速的交付和部署

传统：一对帮助文档，安装程序。

Docker：打包镜像发布测试一键运行。

更便捷的升级和扩缩容

使用了 Docker之后，我们部署应用就和搭积木一样
项目打包为一个镜像，扩展服务器A！服务器B

更简单的系统运维
在容器化之后，我们的开发，测试环境都是高度一致的

更高效的计算资源利用

Docker是内核级别的虚拟化，可以在一个物理机上可以运行很多的容器实例！服务器的性能可以被压榨到极致。

### Docker安装

##### Docker的基本组成

- 镜像（image)：

  docker镜像就好比是一个目标，可以通过这个目标来创建容器服务，tomcat镜像==>run==>容器（提供服务器），==通过这个镜像可以创建多个容器==（最终服务运行或者项目运行就是在容器中的）。

- 容器(container)：

  Docker利用容器技术，独立运行一个或者一组应用，通过镜像来创建的.
  启动，停止，删除，基本命令
  ==目前就可以把这个容器理解为就是一个简易的 Linux系统==。

- 仓库(repository)：

  仓库就是存放镜像的地方！
  仓库分为公有仓库和私有仓库。(很类似git)
  Docker Hub是国外的。
  阿里云…都有容器服务器(配置镜像加速!)

  ##### 安装Docker

- 环境要求，Linux要求内核3.0以上

  ```bash
    # 系统信息
    [root@hyu ~]# cat /etc/os-release 
    NAME="CentOS Linux"
    VERSION="7 (Core)"
    ID="centos"
    ID_LIKE="rhel fedora"
    VERSION_ID="7"
    PRETTY_NAME="CentOS Linux 7 (Core)"
    ANSI_COLOR="0;31"
    CPE_NAME="cpe:/o:centos:centos:7"
    HOME_URL="https://www.centos.org/"
    BUG_REPORT_URL="https://bugs.centos.org/"
    CENTOS_MANTISBT_PROJECT="CentOS-7"
    CENTOS_MANTISBT_PROJECT_VERSION="7"
    REDHAT_SUPPORT_PRODUCT="centos"
    REDHAT_SUPPORT_PRODUCT_VERSION="7"
    # 内核版本
    [root@hyu ~]# uname -r
    3.10.0-1062.18.1.el7.x86_64
  ```

- 安装步骤，可去官方文档查看

  ```bash
    #1.卸载旧版本
    yum remove docker \
                      docker-client \
                      docker-client-latest \
                      docker-common \
                      docker-latest \
                      docker-latest-logrotate \
                      docker-logrotate \
                      docker-engine
    #2.需要的安装包
    yum install -y yum-utils
    #3.设置镜像的仓库
    yum-config-manager \
        --add-repo \
        https://download.docker.com/linux/centos/docker-ce.repo
    #默认是从国外的，不推荐
    #推荐使用国内的
    yum-config-manager \
        --add-repo \
        https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
    #更新yum软件包索引
    yum makecache fast
    #4.安装docker相关的 docker-ce 社区版 而ee是企业版
    yum install docker-ce docker-ce-cli containerd.io
    #5、启动docker
    docker systemctl start docker
    #6. 使用docker version查看是否按照成功
    docker version
    #7. 测试
    docker run hello-world`
  ```

- 卸载docker

  ```bash
    #1. 卸载依赖
    yum remove docker-ce docker-ce-cli containerd.io
  #2. 删除资源
    rm -rf /var/lib/docker
  # /var/lib/docker 是docker的默认工作路径！
  ```

  ##### 阿里云镜像加速
  
  1、登录阿里云找到容器服务
  
  

2、找到镜像加速器
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210413165024966.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDIzNTUzMg==,size_16,color_FFFFFF,t_70)

3、配置使用
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210413165036938.png)

##### docker run image 命令 流程图

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210413165151174.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDIzNTUzMg==,size_16,color_FFFFFF,t_70)

##### 底层原理

Docker是怎么工作的？

Docker是一个Client-Server结构的系统，Docker的守护进程运行在主机上。通过Socket从客户端访问！

Docker-Server接收到Docker-Client的指令，就会执行这个命令！

**为什么Docker比Vm快**
1、docker有着比虚拟机更少的抽象层。由于docker不需要Hypervisor实现硬件资源虚拟化,运行在docker容器上的程序直接使用的都是实际物理机的硬件资源。因此在CPU、内存利用率上docker将会在效率上有明显优势。
2、docker利用的是宿主机的内核,而不需要Guest OS。

> GuestOS： VM（虚拟机）里的的系统（OS）;
> HostOS：物理机里的系统（OS）；
> ![在这里插入图片描述](https://img-blog.csdnimg.cn/20210413165332643.png?type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDIzNTUzMg==,size_16,color_FFFFFF,t_70)

因此,==当新建一个容器时,docker不需要和虚拟机一样重新加载一个操作系统内核。从而避免引导、加载操作系统内核返个比较费时费资源的过程==,当新建一个虚拟机时,虚拟机软件需要加载GuestOS,返个新建过程是分钟级别的。而==docker由于直接利用宿主机的操作系统==,则省略了这个复杂的过程,因此新建一个docker容器只需要几秒钟。

### Docker的常用命令

##### 帮助命令

```bash
docker version    #显示docker的版本信息。
docker info       #显示docker的系统信息，包括镜像和容器的数量
docker 命令 --help #帮助命令
```

##### 镜像命令

```bash
docker images             # 查看所有本地主机上的镜像 可以使用docker image ls代替
docker search             # 搜索镜像
docker pull 镜像名[:tag]    # 下载镜像 docker image pull
docker rmi -f            # 删除镜像 docker image rm -f 强制删除
docker rmi -f $(docker images -aq) # 删除全部的镜像
```

##### 容器命令

```bash
docker run 镜像id         # 新建容器并启动
docker run [可选参数] image | docker container run [可选参数] image 
#参书说明
--name="Name"        容器名字 tomcat01 tomcat02 用来区分容器
-d                    后台方式运行
-it                 使用交互方式运行，进入容器查看内容
-p                    指定容器的端口 -p 8080(宿主机):8080(容器)
        -p ip:主机端口:容器端口
        -p 主机端口:容器端口(常用)
        -p 容器端口
        容器端口
-P(大写)                 随机指定端口
docker ps                 # 列出所有运行的容器 docker container list
#docker ps命令 #列出当前正在运行的容器
  -a, --all             Show all containers (default shows just running)
  -n, --last int        Show n last created containers (includes all states) (default -1)
  -q, --quiet           Only display numeric IDs
docker rm                 # 容器id 删除指定容器
docker start 容器id         #启动容器
docker restart 容器id     #重启容器
docker stop 容器id         #停止当前正在运行的容器
docker kill 容器id         #强制停止当前容器
exit #容器直接退出
ctrl +P +Q #容器不停止退出
```

### 其他常用命令

##### 后台启动命令

```bash
# 命令 docker run -d 镜像名
➜  ~ docker run -d centos
```

##### 查看日志

```bash
docker logs --help
Options:
      --details        Show extra details provided to logs 
*  -f, --follow         Follow log output
      --since string   Show logs since timestamp (e.g. 2013-01-02T13:23:37) or relative (e.g. 42m for 42 minutes)
*      --tail string    Number of lines to show from the end of the logs (default "all")
*  -t, --timestamps     Show timestamps
      --until string   Show logs before a timestamp (e.g. 2013-01-02T13:23:37) or relative (e.g. 42m for 42 minutes)
➜  ~ docker run -d centos /bin/sh -c "while true;do echo 6666;sleep 1;done" #模拟日志      
#显示日志
-tf        #显示日志信息（一直更新）
--tail number #需要显示日志条数
docker logs -t --tail n 容器id #查看n行日志
docker logs -ft 容器id #跟着日志
```

##### 查看镜像的元数据

```bash
# 命令
docker inspect 容器id
```

##### 进入当前正在运行的容器

```bash
# 我们通常容器都是使用后台方式运行的，需要进入容器，修改一些配置
# 命令 
docker exec -it 容器id bashshell
#测试
➜  ~ docker ps    # 查看
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
55321bcae33d        centos              "/bin/sh -c 'while t…"   10 minutes ago      Up 10 minutes                           bold_bell
a7215824a4db        centos              "/bin/sh -c 'while t…"   13 minutes ago      Up 13 minutes                           zen_kepler
55a31b3f8613        centos              "/bin/bash"              15 minutes ago      Up 15 minutes                           lucid_clarke
# 方式一
➜  ~ docker exec -it 55321bcae33d /bin/bash        # 进入
# 方式二
docker attach 容器id
#测试
docker attach 55321bcae33d 
正在执行当前的代码...
区别
#docker exec     # 进入当前容器后开启一个新的终端，可以在里面操作。（常用）
#docker attach     # 进入容器正在执行的终端
```

##### 从容器内拷贝到主机上

```bash
docker cp 容器id:容器内路径   主机目的路径
#进入docker容器内部
➜  ~ docker exec -it  55321bcae33d /bin/bash 
[root@55321bcae33d /]# ls
bin  etc   lib    lost+found  mnt  proc  run   srv  tmp  var
dev  home  lib64  media       opt  root  sbin  sys  usr
#新建一个文件
[root@55321bcae33d /]# echo "hello" > java.java
[root@55321bcae33d /]# cat java.java 
hello
[root@55321bcae33d /]# exit
exit
➜  ~ docker cp 55321bcae33d:/java.java /    #拷贝
➜  ~ cd /              
➜  / ls  #可以看见java.java存在
```

### 命令小结

```bash
 attach      Attach local standard input, output, and error streams to a running container
  #当前shell下 attach连接指定运行的镜像
  build       Build an image from a Dockerfile # 通过Dockerfile定制镜像
  commit      Create a new image from a container's changes #提交当前容器为新的镜像
  cp          Copy files/folders between a container and the local filesystem #拷贝文件
  create      Create a new container #创建一个新的容器
  diff        Inspect changes to files or directories on a container's filesystem #查看docker容器的变化
  events      Get real time events from the server # 从服务获取容器实时时间
  exec        Run a command in a running container # 在运行中的容器上运行命令
  export      Export a container's filesystem as a tar archive #导出容器文件系统作为一个tar归档文件[对应import]
  history     Show the history of an image # 展示一个镜像形成历史
  images      List images #列出系统当前的镜像
  import      Import the contents from a tarball to create a filesystem image #从tar包中导入内容创建一个文件系统镜像
  info        Display system-wide information # 显示全系统信息
  inspect     Return low-level information on Docker objects #查看容器详细信息
  kill        Kill one or more running containers # kill指定docker容器
  load        Load an image from a tar archive or STDIN #从一个tar包或标准输入中加载一个镜像[对应save]
  login       Log in to a Docker registry #
  logout      Log out from a Docker registry
  logs        Fetch the logs of a container
  pause       Pause all processes within one or more containers
  port        List port mappings or a specific mapping for the container
  ps          List containers
  pull        Pull an image or a repository from a registry
  push        Push an image or a repository to a registry
  rename      Rename a container
  restart     Restart one or more containers
  rm          Remove one or more containers
  rmi         Remove one or more images
  run         Run a command in a new container
  save        Save one or more images to a tar archive (streamed to STDOUT by default)
  search      Search the Docker Hub for images
  start       Start one or more stopped containers
  stats       Display a live stream of container(s) resource usage statistics
  stop        Stop one or more running containers
  tag         Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE
  top         Display the running processes of a container
  unpause     Unpause all processes within one or more containers
  update      Update configuration of one or more containers
  version     Show the Docker version information
  wait        Block until one or more containers stop, then print their exit codes
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/202104131714318.jpg?type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDIzNTUzMg==,size_16,color_FFFFFF,t_70#pic_center)

### 作业练习

##### 通过docker安装nginx

- 搜索nginx（可以去dockerhub上，或者是使用命令行）

  ```
    [root@hyu ~]# docker search nginx
  ```

- 拉取nginx（最新版）

  ```
  [root@hyu ~]# docker pull nginx
  Using default tag: latest
    latest: Pulling from library/nginx
  ```

- 查看镜像

  ```
    [root@hyu ~]# docker images
    REPOSITORY    TAG       IMAGE ID       CREATED         SIZE
    nginx         latest    519e12e2a84a   41 hours ago    133MB
    centos        latest    300e315adb2f   4 months ago    209MB
    hello-world   latest    bf756fb1ae65   15 months ago   13.3kB
  ```

- 运行容器

  ```
    # 参数说明: -d: 后台运行 | --name: 容器名称 | -p: 端口暴露
    [root@hyu ~]# docker run -d --name nginx01 -p:3344:80 nginx
    9ab1494c7399ea7f6d8a659453c3c91276a6a1a93c03e43eb68e0681b483063f
  ```

  可以通过外网访问nginx: http://39.97.238.45:3344/

- 端口暴露的概念![在这里插入图片描述](https://img-blog.csdnimg.cn/20210412084435874.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDIzNTUzMg==,size_16,color_FFFFFF,t_70)

- 查看正在运行的容器

  ```bash
    [root@hyu ~]# docker ps
    CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                 NAMES
    9ab1494c7399   nginx     "/docker-entrypoint.…"   7 seconds ago   Up 6 seconds   0.0.0.0:3344->80/tcp  nginx01
  ```

- 进入容器

  ```bash
    # 参数说明 -it: id|| 名称 | /bin/bash: 交互进入
    [root@hyu ~]# docker exec -it nginx01 /bin/bash
    root@9ab1494c7399:/# whereis nginx
    nginx: /usr/sbin/nginx /usr/lib/nginx /etc/nginx /usr/share/nginx
    root@9ab1494c7399:/# cd /etc/nginx
    root@9ab1494c7399:/etc/nginx# ls
    conf.d        koi-utf  mime.types  nginx.conf   uwsgi_params
    fastcgi_params    koi-win  modules     scgi_params  win-utf
    root@9ab1494c7399:/etc/nginx#
  ```

- 停止容器

  ```bash
    [root@hyu ~]# docker stop 9ab1494c7399
    9ab1494c7399
  ```

- 问题

  > 每次需要改动nginx配置文件，都需要进入容器内部，十分麻烦，我要是可以在容器外部提供一个映射路径，达到在容器修改文件，容器内部就可以自动修改，-v 数据卷！
  >
  > ##### 通过docker部署tomcat

- 官方命令，因为通过run运行，可以直接下载并运行

  ```bash
    # 参数说明: -it: 直接进去运行 | -rm: 
    docker run -it --rm -p 8888:8080 tomcat:9.0
    # 我们之前的启动都是后台，停止了容器之后，容器还是可以查到
    # 而docker run -it --rm: 一般用来测试，就是用完即删除，就是容器查不到
  ```

- 拉取运行

  ```bash
    # 拉取最新版本
    [root@hyu ~]# docker pull tomcat
    Using default tag: latest
    # 查看下载的镜像
    [root@hyu ~]# docker images
    REPOSITORY    TAG       IMAGE ID       CREATED         SIZE
    tomcat        latest    bd431ca8553c   22 hours ago    667MB
    nginx         latest    519e12e2a84a   42 hours ago    133MB
    tomcat        9.0       b72e45a11ad9   5 days ago      667MB
    centos        latest    300e315adb2f   4 months ago    209MB
    hello-world   latest    bf756fb1ae65   15 months ago   13.3kB
    # 运行tomcar
    [root@hyu ~]# docker run -d -p 3355:8080 --name tomcat01 tomcat:9.0
    3a87bbdeb1536ebb1f190cc3416f0e3dbd6be82c549454fb0e2c65a53ff5d4b9
    # 外网测试访问: http://39.97.238.45:3355/, 可以访问，但是404
    # 问题查看: 1. linux命令少了 | 2.wbeapps没有项目
    # 原因: 阿里云镜像默认是最小的镜像，所以不必要的都剔除掉
    # 交互进入容器
    [root@hyu ~]# docker exec -it tomcat01 /bin/bash
    root@3a87bbdeb153:/usr/local/tomcat# ls
    # 查看全部内容
    root@3a87bbdeb153:/usr/local/tomcat# ls -al
    total 176
    ...
    drwxr-xr-x 2 root root  4096 Apr  6 22:46 webapps
    drwxr-xr-x 7 root root  4096 Mar 30 10:29 webapps.dist
    drwxrwxrwx 2 root root  4096 Mar 30 10:29 work
    # 进入webapps目录
    root@3a87bbdeb153:/usr/local/tomcat# cd webapps
    # 查看发现没有任何内容，所以404
    root@3a87bbdeb153:/usr/local/tomcat/webapps# ls
    root@3a87bbdeb153:/usr/local/tomcat/webapps# 
    # 进入容器后，我们还可以发现一个文件夹webapps.dist,进入之后，发现里面有项目，所以我们可以把其中的项目拷贝到webapps文件夹中，这样再次访问就可以看到tomcat的首页了
    root@3a87bbdeb153:/usr/local/tomcat/webapps.dist# ls    - 查看webapps.dist的内容
    ROOT  docs  examples  host-manager  manager
    root@3a87bbdeb153:/usr/local/tomcat/webapps.dist# cd ..
    root@3a87bbdeb153:/usr/local/tomcat# cp -r webapps.dist/* webapps    - 拷贝内容
    root@3a87bbdeb153:/usr/local/tomcat# cd webapps
    root@3a87bbdeb153:/usr/local/tomcat/webapps# ls        - 拷贝完成之后，查看webapps下的内容
    ROOT  docs  examples  host-manager  manager
  ```

- 思考问题

  > 我们以后要部署项目，如果每次都要进入容器是不是十分麻烦﹖我要是可以在容器外部提供一个映射路径，webapps ,我们在外部放置项目﹐就自动同步到内部就好了 !

##### 通过docker部署es + kibana

```bash
#
# es 暴露的端口很多
# es 十分的耗内存
# es 的数据一般需要放到安全目录！挂载
# -- net somenetwork ? 网络配置
# 启动 elasticsearch
[root@hyu ~]# docker run -d --name elasticsearch --net somenetwork -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" elasticsearch:7.6.2
# 启动了 linux就卡住了， docker stats: 查看 cpu 的状态
# 测试es是否成功了
[root@hyu ~]# curl localhost:9200
{
  "name" : "4312005f806d",
  "cluster_name" : "docker-cluster",
  "cluster_uuid" : "cP69XdDdSSSnTATKs_RCLw",
  "version" : {
    "number" : "7.6.2",
    "build_flavor" : "default",
    "build_type" : "docker",
    "build_hash" : "ef48eb35cf30adf4db14086e8aabd07ef6fb113f",
    "build_date" : "2020-03-26T06:34:37.794943Z",
    "build_snapshot" : false,
    "lucene_version" : "8.4.0",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
# 增加内存的限制，修改配置文件 -e 环境配置修改
[root@hyu ~]# docker run -d --name elasticsearch02 -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -e ES_JAVA_OPTS="-Xms64m -Xmx512m" elasticsearch:7.6.2
dae35d256b40f9d74a448ab087dc5e168b66ca16654ecc4ced28f2bc961e3ced
# 查看cpu状态，docker stats
CONTAINER ID   NAME              CPU %     MEM USAGE / LIMIT   MEM %     NET I/O   BLOCK I/O    PIDS
dae35d256b40   elasticsearch02   1.00%     356.1MiB / 3.7GiB   9.40%     0B / 0B   0B / 700kB   42
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/2021041213342072.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDIzNTUzMg==,size_16,color_FFFFFF,t_70)