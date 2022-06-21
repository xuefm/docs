# nginx 反向代理 取得真实IP和域名

一、反向代理配置：

**完整配置示例**

(/etc/nginx/nginx.conf)   nginx.conf： 

```nginx
worker_processes  1;
events {
    worker_connections  1024;
} 
http {
    include       mime.types;
    default_type  application/octet-stream;
    sendfile        on;
    keepalive_timeout  65; 

    upstream backend {             
       server 192.168.56.4;
       server 192.168.56.5;　　　　fair;
    } 

    server {
        listen       80;
        server_name  _; 

        location / {

        #设置主机头和客户端真实地址，以便服务器获取客户端真实IP
             proxy_set_header Host $host;
             proxy_set_header X-Real-IP $remote_addr;
             proxy_set_header REMOTE-HOST $remote_addr;
             proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

             #禁用缓存
             proxy_buffering off; 

             #反向代理的地址
             proxy_pass http://backend;    
        }
    } 
} 
```

二、获取真实客户端ip

nginx反向代理后，在应用中取得的ip都是反向代理服务器的ip，取得的域名也是反向代理配置的url的域名，解决该问题，需要在nginx反向代理配置中添加一些配置信息，目的将客户端的真实ip和域名传递到应用程序中。

nginx反向代理配置时，一般会添加下面的配置：

   proxy_set_header Host $host;
   proxy_set_header X-Real-IP $remote_addr;
   proxy_set_header REMOTE-HOST $remote_addr;
   proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

**其中第一行关于host的配置，是关于域名传递的配置，余下跟IP相关。**

**[Java](http://lib.csdn.net/base/java)取得客户端真实IP：**

 ```java
public String getClientIP(HttpServletRequest request) {   
    String ip = request.getHeader("x-forwarded-for");   
    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {   
        ip = request.getHeader("Proxy-Client-IP");   
    }   
    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {   
        ip = request.getHeader("WL-Proxy-Client-IP");   
  
    }   
    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {   
        ip = request.getRemoteAddr();   
    }   
    return ip;   
}  
 ```

**java取得域名：**

 

Java代码  

```java
request.getServerName()  
```
