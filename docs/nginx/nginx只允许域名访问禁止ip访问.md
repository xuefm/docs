这样设置可以防止ip地址暴露出去，增强网站的安全性

打开nginx的配置文件，下面是原先的80端口的配置文件

```nginx
server {
	listen 80 default_server; //这里的default_server要删除
	server_name www.xxxxxxxx.con;
	
	location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }
}
```

我们的做法是新加一个80端口配置，记得把上面配置中80端口后面的default_server删掉，不然重新加载的时候会报错

```nginx
server {
  listen 80 default_server; //这里的default_server要保留
  server_name _;
  return 403;
}
```

配置完后重新加载nginx配置文件

```bash
sudo nginx -s reload
```

然后在网页输入ip地址时，会出现403，表示设置成功