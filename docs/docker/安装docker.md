# Docker

Docker从1.13版本之后采用时间线的方式作为版本号，分为社区版CE和企业版EE。

社区版是免费提供给个人开发者和小型团体使用的，企业版会提供额外的收费服务，比如经过官方测试认证过的基础设施、容器、插件等。

社区版按照stable和edge两种方式发布，每个季度更新stable版本，如17.06，17.09；每个月份更新edge版本，如17.09，17.10。

#  一、安装docker

1、Docker 要求 CentOS 系统的内核版本高于 3.10 ，查看本页面的前提条件来验证你的CentOS 版本是否支持 Docker 。

通过 **uname -r** 命令查看你当前的内核版本

```bash
uname -r
```

2、使用 `root` 权限登录 Centos。确保 yum 包更新到最新。

```bash
yum update
```

3、卸载旧版本(如果安装过旧版本的话)

```bash
yum remove docker  docker-common docker-selinux docker-engine
```

4、安装需要的软件包， yum-util 提供yum-config-manager功能，另外两个是devicemapper驱动依赖的

```bash
yum install -y yum-utils device-mapper-persistent-data lvm2
```

5、设置yum源

```bash
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
```

 ![img](docker_img/1107037-20180128094640209-1433322312.png)

更新yum缓存

　　　　

```bash
yum makecache fast
```

6、可以查看所有仓库中所有docker版本，并选择特定版本安装

```bash
yum list docker-ce --showduplicates | sort -r
```

![img](docker_img/1107037-20180128095038600-772177322.png)

7、安装docker

```bash
yum install docker-ce  #由于repo中默认只开启stable仓库，故这里安装的是最新稳定版17.12.0
yum install <FQPN>  # 例如：sudo yum install docker-ce-17.12.0.ce
```

 ![img](docker_img/1107037-20180128103448287-493824081.png)

8、启动并加入开机启动

```bash
systemctl start docker
systemctl enable docker
```

9、验证安装是否成功(有client和service两部分表示docker安装启动都成功了)

```bash
docker version
```

![img](docker_img/1107037-20180128104046600-1053107877.png)

 

#  二、问题

1、因为之前已经安装过旧版本的docker，在安装的时候报错如下：

```tex
Transaction check error:
  file /usr/bin/docker from install of docker-ce-17.12.0.ce-1.el7.centos.x86_64 conflicts with file from package docker-common-2:1.12.6-68.gitec8512b.el7.centos.x86_64
  file /usr/bin/docker-containerd from install of docker-ce-17.12.0.ce-1.el7.centos.x86_64 conflicts with file from package docker-common-2:1.12.6-68.gitec8512b.el7.centos.x86_64
  file /usr/bin/docker-containerd-shim from install of docker-ce-17.12.0.ce-1.el7.centos.x86_64 conflicts with file from package docker-common-2:1.12.6-68.gitec8512b.el7.centos.x86_64
  file /usr/bin/dockerd from install of docker-ce-17.12.0.ce-1.el7.centos.x86_64 conflicts with file from package docker-common-2:1.12.6-68.gitec8512b.el7.centos.x86_64
```

2、卸载旧版本的包

```bash
yum erase docker-common-2:1.12.6-68.gitec8512b.el7.centos.x86_64
```

![img](docker_img/1107037-20180128103145287-536100760.png)

3、再次安装docker

```bash
yum install docker-ce
```

https://www.cnblogs.com/yufeng218/p/8370670.html



# 三、设置阿里云镜像加速和日志配置

```bash
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://8dqfgjuq.mirror.aliyuncs.com"],
  "log-driver":"json-file",
  "log-opts": {"max-size":"100m", "max-file":"50"}
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
```



# 四、docker-compose

```bash
yum install docker-compose-plugin -y　
```

查看版本

```bash
docker compose version
```