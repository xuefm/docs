### 创建容器时

```bash
docker run --restart=always 
```

**--restart**具体参数值详细信息：

**no** - 容器退出时，不重启容器；

**on-failure** - 只有在非0状态退出时才从新启动容器；

**always** - 无论退出状态是如何，都重启容器；


还可以在使用on - failure策略时，指定Docker将尝试重新启动容器的最大次数。默认情况下，Docker将尝试永远重新启动容器。

```bash
docker run --restart=on-failure:10 
```

### 容器已经创建后

```bash
docker update --restart=always 容器id/容器名
```



