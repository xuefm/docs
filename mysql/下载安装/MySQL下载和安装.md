# windows安装mysql

1.去下载

![官网下载mysql](MySQL下载和安装img\官网下载mysql.gif)





2.安装过程

![安装过程mysql](MySQL下载和安装img\安装过程mysql.gif)

3.配置环境变量

![配置环境变量](MySQL下载和安装img\配置环境变量.gif)

# linux安装mysql

## 一、下载安装

### 1.yum安装方式（相对简单）

##### 1．配置Mysql 8.0安装源

```bash
rpm -Uvh https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
```

##### 2．安装Mysql 8.0

```bash
yum --enablerepo=mysql80-community install mysql-community-server
```

##### 3．启动mysql服务

```bash
service mysqld start
```

##### 4．查看mysql服务运行状态

```bash
service mysqld status
设置开机自启动
# chkconfig mysqld on  或者  systemctl enable mysqld
```

##### 5．查看root临时密码

安装完mysql之后，会生成一个临时的密码让root用户登录

```bash
grep "A temporary password" /var/log/mysqld.log
```

##### 6.修改root用户密码

```mysql
ALTER USER 'root'@'localhost' IDENTIFIED BY 'new password';
```

提示**密码不满足密码验证策略**

降低密码校验等级

**查看原来的密码校验**

```mysql
SHOW VARIABLES LIKE 'validate_password.%';
```

提示不让看

```mysql
#`validate_password.length` 是密码的最小长度，默认是8，我们把它改成4
set global validate_password.length=4;
#`validate_password.policy` 验证密码的复杂程度，我们把它改成0
set global validate_password.policy=0;
#`validate_password.check_user_name` 用户名检查，用户名和密码不能相同，我们也把它去掉
set global validate_password.check_user_name=off;
```

现在再执行修改密码的命令：

```mysql
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
```



## 二、设置远程连接

```bash
#登录mysql
mysql -u root –p
#切换数据库 到use
mysql>use mysql;
# 修改user表
mysql>update user set host = '%' where user = 'root';
# 查看修改结果
mysql>select host, user from user;
# 刷新配置
mysql>FLUSH PRIVILEGES;
```



## 三、卸载

查看安装的MySQL软件

```bash
rpm -qa|grep mysql
```

一个一个卸载即可

```bash
rpm -e MySQL-server-5.6.17-1.el6.i686
rpm -e MySQL-client-5.6.17-1.el6.i686
```

删除mysql服务

```bash
chkconfig --list | grep -i mysql
chkconfig --del mysql
```

清空相关目录

```bash
whereis mysql 或者 find / -name mysql
mysql: /usr/lib/mysql /usr/share/mysql
#清空相关mysql的所有目录以及文件
rm -rf /usr/lib/mysql
rm -rf /usr/share/mysql
rm -rf /usr/my.cnf
```



[cysqld]
datadir-/usr/local/mysql/data
socket=/usr/local/mysql/tmp/mysql. sock
user=mysql
Disabling symbolic-links is recomended to prevent assorted security risks
symbolic-links=O
[mysqld safe]
Log- error=/var/log/mysqld. Log
pid-file=/var/run/mysqld/mysqld. pid
的改后的智时就 .
[client]
s0c ketm /us r/1ocal /mysql /tmp/mysql sock