# [CentOS7安装JDK11](https://www.cnblogs.com/greamrod/p/12922593.html)

第一步：肯定是下载jdk，我下载的是".tar.gz"格式的文件。然后传到合适的地址上。





第二步：解压jdk的安装包，"tar -zxvf jdk-11_linux-x64_bin.tar.gz" 之后就看到当前目录下多了一个jdk-11的文件；

![安装jdk01](linux_img/安装jdk01.png)

第三步: 运行 vim /etc/profile 命令

​       在文件的末尾处添加上一下内容：

```tex
#java environment
export JAVA_HOME=/home/jdk-11.0.11
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export PATH=$PATH:$JAVA_HOME/bin
```



![img](linux_img\安装jdk02.png)

第四步：使配置文件生效 ：

```bash
source /etc/profile
```



第五步：运行java -version 出现以下信息，就成功了

```bash
java -version
```



![img](linux_img\安装jdk03.png)

