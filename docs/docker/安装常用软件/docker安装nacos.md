





~~~~bash
#拉取镜像
docker pull nacos/nacos-server
#创建容器并启动
docker run --name nacos -e JVM_XMS=256m -e JVM_XMX=256m  -e MODE=standalone -p 8848:8848 -p 9848:9848 -d nacos/nacos-server
~~~~

