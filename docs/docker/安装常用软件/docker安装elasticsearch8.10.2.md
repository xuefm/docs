

## 拉取镜像

```bash
# elasticsear镜像
docker pull elasticsearch:8.10.2
# kibana镜像
docker pull kibana:8.10.2

```

## elasticsearch

### 创建文件夹

```bash
mkdir -p /mydata/elasticsearch/config
mkdir -p /mydata/elasticsearch/data
mkdir -p /mydata/elasticsearch/logs
mkdir -p /mydata/elasticsearch/plugins

## 保证权限
chmod -R 777 /mydata/elasticsearch

#启动一下 
docker run --name elasticsearch -p 9200:9200 -p9300:9300 \
-e "discovery.type=single-node" \
-e ES_JAVA_OPTS="-Xms64m -Xmx128m" \
-d elasticsearch:8.10.2

#将配置文件拷贝出来
docker cp -a elasticsearch:/usr/share/elasticsearch/config /mydata/elasticsearch
docker cp -a elasticsearch:/usr/share/elasticsearch/data /mydata/elasticsearch
docker cp -a elasticsearch:/usr/share/elasticsearch/logs /mydata/elasticsearch
docker cp -a elasticsearch:/usr/share/elasticsearch/plugins /mydata/elasticsearch

```

### 删除容器

```bash
docker rm elasticsearch
```

### 重新创建容器

```bash
docker run --name elasticsearch -p 9200:9200 -p9300:9300 \
-e "discovery.type=single-node" \
-e ES_JAVA_OPTS="-Xms64m -Xmx128m" \
-v /mydata/elasticsearch/config:/usr/share/elasticsearch/config \
-v /mydata/elasticsearch/data:/usr/share/elasticsearch/data \
-v /mydata/elasticsearch/logs:/usr/share/elasticsearch/logs \
-v /mydata/elasticsearch/plugins:/usr/share/elasticsearch/plugins \
-d elasticsearch:8.10.2

```



### 修改配置文件

```bash
vi /mydata/elasticsearch/config/elasticsearch.yml 
```

```yml
cluster.name: "docker-cluster"
network.host: 0.0.0.0

#----------------------- BEGIN SECURITY AUTO CONFIGURATION -----------------------
#
# The following settings, TLS certificates, and keys have been automatically      
# generated to configure Elasticsearch security features on 13-12-2023 03:54:02
#
# --------------------------------------------------------------------------------

# Enable security features
#xpack.security.enabled: true(这里改为false)
xpack.security.enabled: false

xpack.security.enrollment.enabled: true

# Enable encryption for HTTP API client connections, such as Kibana, Logstash, and Agents
xpack.security.http.ssl:
  enabled: true
  keystore.path: certs/http.p12

# Enable encryption and mutual authentication between cluster nodes
xpack.security.transport.ssl:
  enabled: true
  verification_mode: certificate
  keystore.path: certs/transport.p12
  truststore.path: certs/transport.p12
#----------------------- END SECURITY AUTO CONFIGURATION -------------------------
#(添加)http.host: 0.0.0.0允许所有ip访问
http.host: 0.0.0.0
```

### 重启容器

```bash
docker restart  elasticsearch
```

