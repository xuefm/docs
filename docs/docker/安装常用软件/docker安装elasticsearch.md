### 拉取镜像

```bash
elasticsear镜像
docker pull elasticsearch:7.8.0
kibana镜像
docker pull kibana:7.8.0
```



创建目录

```bash
## 创建两个文件夹，存配置和数据
mkdir -p /mydata/elasticsearch/config
mkdir -p /mydata/elasticsearch/data
mkdir -p /mydata/elasticsearch/plugins

## 保证权限
chmod -R 777 /mydata/elasticsearch

## 写入配置，代表es可以被远程任何机器访问
echo "http.host: 0.0.0.0">>/mydata/elasticsearch/config/elasticsearch.yml

```



### 运行elasticsearch

```bash
## 9200:http请求端口；9300:分布式集群调用端口;单节点运行；指定内存大小，如果不指定可能占满虚拟机内存；路径挂载
docker run --name elasticsearch -p 9200:9200 -p9300:9300 \
-e "discovery.type=single-node" \
-e ES_JAVA_OPTS="-Xms64m -Xmx128m" \
-v /mydata/elasticsearch/config/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
-v /mydata/elasticsearch/data:/usr/share/elasticsearch/data \
-v /mydata/elasticsearch/plugins:/usr/share/elasticsearch/plugins \
-d elasticsearch:7.8.0

```

elasticsearch配置文件位置 

```tex
/usr/share/elasticsearch/config/elasticsearch.yml
```



### 运行kibana

```bash
#10.0.24.3为本机ip
docker run --name kibana -e I18N_LOCALE=zh-CN -e ELASTICSEARCH_HOSTS=http://10.0.24.3:9200 -p 5601:5601 \
-d kibana:7.8.0
```

kibana配置文件位置 

```tex 
/usr/share/kibana/config/kibana.yml
```

