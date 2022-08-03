### 1.检查docker插件是否安装

**idea默认会自带docker插件**

<img src=".\img\idea_docker_1.png" alt="idea_docker_1" style="zoom:100%;" />



### 2.添加链接

<img src=".\img\idea_docker_2.png" alt="idea_docker_2" style="zoom:100%;" />

**个人建议使用ssh链接，这样不需要开启docker远程连接**

### 3.配置完成

<img src=".\img\idea_docker_3.png" alt="idea_docker_3" style="zoom:100%;" />

### 4.解决日志乱码问题

<img src=".\img\idea_docker_5.png" alt="idea_docker_5" style="zoom:100%;" />

文件末尾添加

```
-Dfile.encoding=utf-8
```

再重启idea即可