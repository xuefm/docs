# Nginx从安装到高可用，一篇搞定！

- 一、Nginx安装
- 二、配置反向代理
- 三、配置负载均衡
- 四、upstream指令参数
- 五、配置ssl证书提供https访问
- 六、配置ha nginx
- 七、LVS（Linux Virtual Server）实现高可用负载均衡
- 附：LVS的负载均衡算法
- 八、搭建Keepalived+Lvs+Nginx高可用集群负载均衡

------

## 一、Nginx安装

#### 1、去官网http://nginx.org/下载对应的nginx包，推荐使用稳定版本

#### 2、上传nginx到linux系统

#### 3、安装依赖环境

(1)安装gcc环境

```bash
yum install gcc-c++
```

(2)安装PCRE库，用于解析正则表达式

```bash
yum install -y pcre pcre-devel
```

(3)zlib压缩和解压缩依赖

```bash
yum install -y zlib zlib-devel
```

(4)SSL 安全的加密的套接字协议层，用于HTTP安全传输，也就是https

```bash
yum install -y openssl openssl-devel
```

#### 4、解压，需要注意，解压后得到的是源码，源码需要编译后才能安装

```bash
tar -zxvf nginx-1.16.1.tar.gz
```

#### 5、编译之前，先创建nginx临时目录，如果不创建，在启动nginx的过程中会报错

```bash
mkdir /var/temp/nginx -p
```

#### 6、在nginx目录，输入如下命令进行配置，目的是为了创建makefile文件

```bash
./configure \   
--prefix=/usr/local/nginx \    
--pid-path=/var/run/nginx/nginx.pid \    
--lock-path=/var/lock/nginx.lock \    
--error-log-path=/var/log/nginx/error.log \    
--http-log-path=/var/log/nginx/access.log \    
--with-http_gzip_static_module \    
--http-client-body-temp-path=/var/temp/nginx/client \    
--http-proxy-temp-path=/var/temp/nginx/proxy \    
--http-fastcgi-temp-path=/var/temp/nginx/fastcgi \    
--http-uwsgi-temp-path=/var/temp/nginx/uwsgi \    
--http-scgi-temp-path=/var/temp/nginx/scgi
```

注：代表在命令行中换行，用于提高可读性配置命令：

![图片](https://mmbiz.qpic.cn/mmbiz_png/sTnayibHfVq5BLkrp5IOVsy6W8tLvk0icz7RZdyjiaaIKNz8KmEs5r6rw43Xp0UUMgIfWiaCq9DMZVFGMBA1Fo8Shw/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

图片

#### 7、make编译&安装

```bash
make
make install
```

#### 8、进入sbin目录启动nginx

```bash
启动：nginx停止：./nginx -s stop重新加载：./nginx -s reload
```

## 二、配置反向代理

1、配置upstream

```nginx
upstream [proxyName] {
    server 192.168.1.173:8080;
    server 192.168.1.174:8080;
    server 192.168.1.175:8080;
}
```

2、配置server

```nginx
server {
    listem  80;
    server_name www.tomcats.com;

    location / {
        proxy_pass http://tomcats;
    }
}
```

## 三、配置负载均衡

nginx默认采用轮训的方式进行负载均衡

1、使用加权轮询

```nginx
upstream [proxyName] {
    server 192.168.1.173:8080 weight=1;
    server 192.168.1.174:8080 weight=5;
    server 192.168.1.175:8080 weight=2;
}
```

2、hash负载均衡

```nginx
upstream [proxyName] {
    ip_hash

    server 192.168.1.173:8080;
    server 192.168.1.174:8080;
    server 192.168.1.175:8080;
}
```

hash算法实际上只会计算 192.168.1这段做哈希

使用ip_hash的注意点：

- 不能把后台服务器直接移除，只能标记down.

3、url hash负载均衡

```nginx
upstream [proxyName] {
    hash $request_url;

    server 192.168.1.173:8080;
    server 192.168.1.174:8080;
    server 192.168.1.175:8080;
}
```

4、最小连接负载均衡

```nginx
upstream [proxyName] {
    least_conn;

    server 192.168.1.173:8080;
    server 192.168.1.174:8080;
    server 192.168.1.175:8080;
}
```

## 四、upstream指令参数

- `max_conns`：限制最大同时连接数 1.11.5之前只能用于商业版
- `slow_start`：单位秒，权重在指定时间内从1上升到指定值，不适用与hash负载均衡、随机负载均衡 如果在 upstream 中只有一台 server，则该参数失效（商业版才有）
- `down`：禁止访问
- `backup`：备用机 只有在其他服务器无法访问的时候才能访问到 不适用与hash负载均衡、随机负载均衡
- `max_fails`：表示失败几次，则标记server已宕机，剔出上游服务 默认值1
- `fail_timeout`：表示失败的重试时间 默认值10

1、keepalived

```nginx
upstream [proxyName] {
    server 192.168.1.173:8080 weight=1;
    server 192.168.1.174:8080 weight=5;
    server 192.168.1.175:8080 weight=2;

    keepalive 32; #保持的连接数
}

server {
    listem  80;
    server_name www.tomcats.com;

    location / {
        proxy_pass http://tomcats;
        proxy_http_version 1.1; #连接的协议版本
        proxy_set_header Connection ""; 清空连接请求头
    }
}
```

2、控制浏览器缓存

```nginx
server {
    listem  80;
    server_name www.tomcats.com;

    location / {
        proxy_pass http://tomcats;
               expires 10s;  #浏览器缓存10秒钟
               #expires @22h30m  #在晚上10点30的时候过期
               #expires -1h  #缓存在一小时前时效
               #expires epoch  #不设置缓存
               #expires off  #缓存关闭，浏览器自己控制缓存
               #expires max  #最大过期时间
    }
}
```

3、反向代理缓存

```nginx
upstream [proxyName] {
    server 192.168.1.173:8080 weight=1;
    server 192.168.1.174:8080 weight=5;
    server 192.168.1.175:8080 weight=2;
}

#proxy_cache_path 设置缓存保存的目录的位置
#keys_zone设置共享内以及占用的空间大小
#mas_size 设置缓存最大空间
#inactive 缓存过期时间，错过此时间自动清理
#use_temp_path 关闭零时目录
proxy_cache_path /usr/local/nginx/upsteam_cache keys_zone=mycache:5m max_size=1g inactive=8h use_temp_path=off;

server {
    listem  80;
    server_name www.tomcats.com;
    #开启并使用缓存
    proxy_cache mycache;
    #针对200和304响应码的缓存过期时间
    proxy_cache_valid 200 304 8h;   

    location / {
        proxy_pass http://tomcats;
    }
}
```

## 五、配置ssl证书提供https访问

#### 1. 安装SSL模块

要在nginx中配置https，就必须安装ssl模块，也就是: `http_ssl_module`。

进入到nginx的解压目录：`/home/software/nginx-1.16.1`

新增ssl模块(原来的那些模块需要保留)

```
./configure \
--prefix=/usr/local/nginx \
--pid-path=/var/run/nginx/nginx.pid \
--lock-path=/var/lock/nginx.lock \
--error-log-path=/var/log/nginx/error.log \
--http-log-path=/var/log/nginx/access.log \
--with-http_gzip_static_module \
--http-client-body-temp-path=/var/temp/nginx/client \
--http-proxy-temp-path=/var/temp/nginx/proxy \
--http-fastcgi-temp-path=/var/temp/nginx/fastcgi \
--http-uwsgi-temp-path=/var/temp/nginx/uwsgi \
--http-scgi-temp-path=/var/temp/nginx/scgi  \
--with-http_ssl_module
```

编译和安装

```bash
makemake install
```

#### 2、配置HTTPS

把ssl证书 `*.crt` 和 私钥 `*.key` 拷贝到`/usr/local/nginx/conf`目录中。

新增 server 监听 443 端口：

```nginx
server {
    listen       443;
    server_name  www.imoocdsp.com;
    # 开启ssl
    ssl     on;
    # 配置ssl证书
    ssl_certificate      1_www.imoocdsp.com_bundle.crt;
    # 配置证书秘钥
    ssl_certificate_key  2_www.imoocdsp.com.key;
    # ssl会话cache
    ssl_session_cache    shared:SSL:1m;
    # ssl会话超时时间
    ssl_session_timeout  5m;
    # 配置加密套件，写法遵循 openssl 标准
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE;
    ssl_prefer_server_ciphers on;
    
    location / {
        proxy_pass http://tomcats/;
        index  index.html index.htm;
    }
}
```

