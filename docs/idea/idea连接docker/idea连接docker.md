### 1.检查docker插件是否安装

**idea默认会自带docker插件**

![img](img\idea_docker_1.png)



### 2.添加链接

![img](img\idea_docker_2.png)

**个人建议使用ssh链接，这样不需要开启docker远程连接**

### 3.配置完成

![img](img\idea_docker_3.png)

### 4.解决日志乱码问题

![img](img\idea_docker_4.png)

文件末尾添加

```
-Dfile.encoding=utf-8
```

再重启idea即可