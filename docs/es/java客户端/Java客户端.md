## 包结构和命名空间客户端

Elasticsearch API很大，被组织成多个特性组，如[Elasticsearch API文档](https://www.elastic.co/guide/en/elasticsearch/reference/8.9/rest-apis.html).

Java API客户机遵循这样的结构:特性组被称为“名称空间”，每个名称空间位于`co.elastic.clients.elasticsearch`.

每个名称空间客户端都可以从顶级Elasticsearch客户端访问。唯一的例外是“搜索”和“文档”API，它们位于`core`子包，可以在主Elasticsearch客户端对象上访问。

下面的代码片段显示了如何使用indexes名称空间客户端来创建索引(lambda语法在[构建API对象](https://www.elastic.co/guide/en/elasticsearch/client/java-api-client/current/building-objects.html)):

```java
// Create the "products" index
ElasticsearchClient client = ...
client.indices().create(c -> c.index("products"));
```

名称空间客户机是非常轻量级的对象，可以动态创建。