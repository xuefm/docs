### 一、安装mysql

```bash
docker run -d -p 3306:3306 --name expectmysql -e MYSQL_ROOT_PASSWORD=root 镜像id或镜像名
```

解释：以后台启动 、端口映射、设置容器名、 参数设置（设置root用户密码）、镜像id或镜像名  

```bash
docker run -itd --name mysql-test -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456  mysql 
```

指定网络

```bash
docker run -d --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root --network expect mysql 
```



```bash
docker exec -it 7681b85e73a1 /bin/sh
```

解释：进入容器、以交互模式、容器id 、/bin/sh

```bash
mysql -p localhost -uroot -p
root

```

解释：连接mysql

```bash
alter user 'root'@'%' identified with mysql_native_password by 'root';
```

解释：设置root账户远程连接权限

**完了**、可以用navicate连接了   （记得打开端口）

