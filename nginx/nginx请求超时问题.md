```nginx
    location / {
    
	     proxy_read_timeout 150;  # 就是这个
	     proxy_pass  http://172.24.217.96:8801/;
	     proxy_set_header Host $host;
        #index  index.html index.htm;
    }
```

# nginx中的超时设置，请求超时、响应等待超时等

# nginx timeout 配置 全局timeout 局部timeout web timeout

 

nginx比较强大,可以针对单个域名请求做出单个连接超时的配置. 

比如些动态解释和静态解释可以根据业务的需求配置

**proxy_connect_timeout :**后端服务器连接的超时时间_发起握手等候响应超时时间

**proxy_read_timeout:**连接成功后_等候后端服务器响应时间_其实已经进入后端的排队之中等候处理（也可以说是后端服务器处理请求的时间）

**proxy_send_timeout :**后端服务器数据回传时间_就是在规定时间之内后端服务器必须传完所有的数据

nginx使用proxy模块时，默认的读取超时时间是60s。

 

 

**1、请求超时**

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```nginx
http {
    include       mime.types;
    server_names_hash_bucket_size  512;     
    default_type  application/octet-stream;
    sendfile        on;
    keepalive_timeout  65;  #保持
    tcp_nodelay on;
    client_header_timeout 15;
    client_body_timeout 15;
    send_timeout 25;
    include vhosts/*.conf;
}
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 

 

**2、后端服务器处理请求的时间设置（页面等待服务器响应时间）**

```nginx
location / {
        ...
        proxy_read_timeout 150;  # 秒
        ...
    }
```















































1. 优化业务代码

一个接口调用超过一分钟，一定有可以优化的地方，看看[数据库](http://www.111cn.net/database/database.html)或者接口的调用是否合理，是否可以合并请求。

2. 修改Nginx的服务器配置

如果实在是优化不了了，可以把Nginx的超时时间上调。
看看时间是否符合要求，在nginx.config里面的三个参数：

```nginx
fastcgi_connect_timeout 300;
fastcgi_send_timeout 300;
fastcgi_read_timeout 300;
```

以上的单位是秒。

如果使用了Nginx的代理，可以在块里加上：

```nginx
proxy_connect_timeout 300s;
proxy_send_timeout 300s;
proxy_read_timeout 300s;
```





变成：

```nginx
location /foo {
   proxy_pass http://xxx.xxx.xxx.xxx:8080/foo;
   proxy_set_header Host $host;
   proxy_set_header X-Real-IP $remote_addr;
   proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
   proxy_connect_timeout 300s;
   proxy_send_timeout 300s;
   proxy_read_timeout 300s;
   access_log /var/log/nginx/access.foo.log main;
   error_log /var/log/nginx/error.foo.log;
}
```



