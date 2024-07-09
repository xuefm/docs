### 1. yum安装

```shell
#添加源
rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
#安装nginx
yum install -y nginx
```

**启动和停止**

```shell
#启动nginx
systemctl start nginx.service
#停止
systemctl stop nginx.service
```

在使用 `yum install -y nginx` 命令安装 Nginx 后，通常情况下，Nginx 的各个目录及主要文件位于以下位置：

1. **配置文件目录**：
   - `/etc/nginx`：Nginx 的配置文件所在目录。
   - `/etc/nginx/nginx.conf`：Nginx 主配置文件，包含全局配置和引入其他配置文件的指令。
2. **网站根目录**：
   - 默认情况下，Nginx 的网站根目录可以在配置文件中指定，通常位于 `/usr/share/nginx/html` 或 `/var/www/html`。
3. **日志文件目录**：
   - `/var/log/nginx`：Nginx 的日志文件所在目录。
   - `/var/log/nginx/access.log`：Nginx 的访问日志文件，记录所有访问请求的信息。
   - `/var/log/nginx/error.log`：Nginx 的错误日志文件，记录服务器运行过程中的错误信息。
4. **站点配置文件目录**：
   - `/etc/nginx/conf.d`：Nginx 的站点配置文件所在目录，通常包含一个或多个以 `.conf` 结尾的配置文件，每个文件对应一个站点或应用的配置。
5. **其他目录**：
   - `/usr/lib/systemd/system`：Systemd 单元文件目录，包含 Nginx 的 Systemd 服务单元文件，用于管理 Nginx 的启动、停止和状态等操作。

请注意，这些目录位置可能会因操作系统版本、Nginx 版本和自定义配置而有所不同。在实际安装过程中，可以通过查看文档或执行命令来确认确切的目录位置

### 2. 源码安装

现在以nginx-1.22.1.tar.gz为例[官网下载](https://nginx.org/en/download.html)

**安装依赖环境(若安装则跳过此步骤)**

```shell
#若无wget命令(有则跳过此步骤)
yum install -y wget
#nginx编译需要依赖gcc环境
yum install gcc-c++
#nginx的http模块使用pcre来解析正则表达式
yum install -y pcre pcre-devel
#nginx的http模块使用pcre来解析正则表达式
yum install -y zlib zlib-devel
#nginx支持的https协议需要ssl加密
yum install -y openssl openssl-devel
```

**下载和编译**

```shell
#下载源码文件
wget https://nginx.org/download/nginx-1.22.1.tar.gz
#解压文件
tar -zxvf nginx-1.22.1.tar.gz
#进入nginx-1.22.1目录
cd nginx-1.22.1
#执行以下命令编译nginx
./configure
make
make install
#完成后可在/usr/local/nginx目录找到相关文件

```

**启动和停止**

```shell
#启动nginx
/usr/local/nginx/sbin/nginx
#停止nginx
/usr/local/nginx/sbin/nginx -s stop
#重启nginx
/usr/local/nginx/sbin/nginx -s reload
```

