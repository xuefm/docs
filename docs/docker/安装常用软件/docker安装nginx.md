#### 搜索nginx

```bash
docker search nginx
```

#### 拉取 nginx

```bash
docker pull nginx
```

#### 随便启动一下nginx

```bash
docker run --name nginx nginx
```

#### 宿主机创建文件夹

```bash
mkdir -p /root/nginx/conf
```

#### 复制容器内的nginx.conf文件到宿主机

```bash
docker cp nginx:/etc/nginx/nginx.conf /root/nginx/conf
```

#### 复制conf.d和html目录

```bash
docker cp nginx:/etc/nginx/conf.d /root/nginx/conf/conf.d
```

```bash
docker cp nginx:/usr/share/nginx/html /root/nginx/html
```

#### 删除原来的容器

```bash
docker stop nginx
docker rm nginx
```

#### 再次创建容器挂载目录

```bash
docker run --name nginx -d -p 80:80 -p 443:443 \
-v /root/nginx/log:/var/log/nginx \
-v /root/nginx/conf/conf.d:/etc/nginx/conf.d \
-v /root/nginx/html:/usr/share/nginx/html \
-v /root/nginx/conf/nginx.conf:/etc/nginx/nginx.conf \
nginx

```

注意文件夹可以直接挂载（但文件夹里的文件不能同步）  文件必须存在才能挂载



这个指定网络

```bash
docker run --name nginx -d -p 80:80 -p 443:443 \
-v /root/nginx/log:/var/log/nginx \
-v /root/nginx/conf/conf.d:/etc/nginx/conf.d \
-v /root/nginx/html:/usr/share/nginx/html \
-v /root/nginx/conf/nginx.conf:/etc/nginx/nginx.conf \
--network expect \
nginx
```

