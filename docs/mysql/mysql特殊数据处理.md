## 1.根据经纬度计算距离

```mysql
mysql> SELECT ST_Distance_Sphere(ST_GeomFromText('POINT(120.26457 30.18534)'), ST_GeomFromText('POINT(120.2428550 30.2035350)')) distance;
+--------------------+
| distance           |
+--------------------+
| 2906.6838888890456 |
+--------------------+
1 row in set (0.01 sec)
```

## 2.JSON数据类型

### 2.1相关函数

| 函数名称           | 描述                                           |
| ------------------ | ---------------------------------------------- |
| JSON_ARRAY         | 创建一个JSON数组                               |
| JSON_OBJECT        | 创建一个JSON对象                               |
| JSON_ARRAY_APPEND  | 在数组末尾添加一个元素                         |
| JSON_ARRAY_INSERT  | 在指定位置插入一个元素到一个数组中             |
| JSON_CONTAINS      | 检查JSON文本是否包含指定路径对应的值           |
| JSON_CONTAINS_PATH | 检查JSON文本是否包含指定路径                   |
| JSON_DEPTH         | 返回JSON文本的最大深度                         |
| JSON_EXTRACT       | 从JSON文本中提取数据                           |
| JSON_INSERT        | 插入数据到JSON文本中指定位置                   |
| JSON_KEYS          | 返回JSON对象的所有键                           |
| JSON_LENGTH        | 返回JSON文本中的元素个数                       |
| JSON_MERGE         | 合并两个或更多JSON文本                         |
| JSON_OBJECTAGG     | 返回值为JSON类型的聚合函数                     |
| JSON_OVERLAPS      | 检查两个JSON文本是否有重叠                     |
| JSON_PRETTY        | 将JSON文本格式化并美化                         |
| JSON_QUOTE         | 对JSON文本中的字符串添加引号                   |
| JSON_REMOVE        | 从JSON文本中移除指定的键                       |
| JSON_REPLACE       | 用新值替换JSON文本中的指定键                   |
| JSON_SEARCH        | 在JSON文本中搜索指定的值，并返回其路径         |
| JSON_SET           | 设置JSON文本中指定路径对应的值                 |
| JSON_STORAGE_FREE  | 释放JSON值占用的存储空间                       |
| JSON_STORAGE_SIZE  | 返回JSON值所占用的存储空间大小                 |
| JSON_TABLE         | 从JSON文本中提取数据，并存储为关系型表格的形式 |
| JSON_TYPE          | 返回JSON值的类型                               |

### 1.JSON_ARRAY 创建一个JSON数组

```sql
--函数 JSON_ARRAY([val[, val] ...])

--示例
SELECT JSON_ARRAY("a","b","c") AS json_arr;
--返回结果   ["a", "b", "c"]

-- 注：这里并不要求数组内元素数据类型一致
SELECT JSON_ARRAY("a","b","c",1,2,3) AS json_arr;
--返回结果   ["a", "b", "c", 1, 2, 3]
```

### 2.JSON_OBJECT 创建一个JSON对象

```sql
--函数 JSON_OBJECT([key, val[, key, val] ...])
--示例
SELECT JSON_OBJECT('name', '张三', 'age', 20, 'gender', 'male') as json_obj;
--返回结果   {"age": 20, "name": "张三", "gender": "male"}
```



### 3.JSON_ARRAY_APPEND在数组末尾添加一个元素

```sql
--函数 JSON_ARRAY_APPEND(json_doc, path, val[, path, val] ...)

--示例
SELECT JSON_ARRAY_APPEND(JSON_ARRAY("a","b","c",1,2,3),"$","**") as json_arr;
--返回结果  ["a", "b", "c", 1, 2, 3, "**"]

SELECT JSON_ARRAY_APPEND(JSON_ARRAY("a","b","c",1,2,3),"$[0]","**") as json_arr;
--返回结果  [["a", "**"], "b", "c", 1, 2, 3]
```

其中，参数解释如下：

- `json_doc`：需要修改的 JSON 文档；
- `path`：要追加元素的路径；
- `val`：要追加的值。

其返回值为修改后的 JSON 文档，如果原 JSON 文档不是合法的 JSON 数组，则返回 `NULL`。

注意，`'$'` 表示向数组末尾添加元素，如果要指定其他位置，则需要使用对应的索引，例如 `$[0]` 表示向数组第一个元素前添加一个新元素

### 4.JSON_ARRAY_INSERT在指定位置插入一个元素到一个数组中

```sql
--函数 JSON_ARRAY_INSERT(json_doc, path, val[, path, val] ...)

--示例
SELECT JSON_ARRAY_INSERT(JSON_ARRAY("a","b","c",1,2,3),"$[1]","**") as json_arr;
--返回结果  ["a", "**", "b", "c", 1, 2, 3]
```

其中，参数解释如下：

- `json_doc`：需要修改的 JSON 文档；
- `path`：要插入元素的路径；
- `val`：要插入的值。

其返回值为修改后的 JSON 文档，如果原 JSON 文档不是合法的 JSON 数组，则返回 `NULL`。

注意，`'$[1]'` 表示向数组第二个元素前添加一个新元素，如果要指定其他位置，则需要使用对应的索引。

### 5.JSON_CONTAINS  检查JSON文本是否包含指定路径对应的值

`JSON_CONTAINS` 是 MySQL 中的一个 JSON 函数，用于判断 JSON 文档中是否包含指定的值或对象。以下是其语法：

```sql
--函数 JSON_CONTAINS(json_doc, val[, path])
select * from test_json where JSON_CONTAINS(`json_array`, '3')
```

其中，参数解释如下：

- `json_doc`：需要查找的 JSON 文档；
- `val`：要查找的值或对象；
- `path`：可选，指定要查找的路径。

其返回值为 `1` 或 `0`，分别表示找到和未找到。

以下是一个示例，假设表 `student` 中的字段 `grades` 是一个 JSON 数组，我们要判断该数组中是否包含成绩 80：

```sql
SELECT JSON_CONTAINS(grades, 80) FROM student WHERE id = 1;
```

如果数组中包含成绩 80，则返回 `1`，否则返回 `0`。

注意，如果要查找的是一个对象，可以在 `val` 参数中直接传入一个 JSON 对象，例如：

```sql
SELECT JSON_CONTAINS(data, '{"name": "Tom", "age": 18}', '$.students') FROM class WHERE id = 1;
```

以上语句表示查找表 `class` 中的 `data` 字段中名为 `students` 的 JSON 数组中是否包含一个名字为 `Tom`，年龄为 `18` 的对象。如果包含，则返回 `1`，否则返回 `0`。







### 分组后用逗号分隔

假设A表中有以下两个字段：user_id和age。要将A表中的user_id用逗号分隔，按age字段进行分组，可以使用MySQL的GROUP_CONCAT函数实现。具体的SQL语句如下所示：

```sql
Copy CodeSELECT age, GROUP_CONCAT(user_id SEPARATOR ',') AS user_ids
FROM A
GROUP BY age;
```

在这条SQL语句中，先选择了age字段和使用GROUP_CONCAT函数连接user_id，使用“,”作为分隔符，并将其命名为user_ids，然后根据age字段进行分组。

执行完这条SQL语句之后，会返回一个结果集，其中每一行代表一个分组，包含该分组的age值和该分组内的所有user_id，用逗号分隔。



### 分组后抓换为json数组

要将A表中的user_id设置为JSON数组，按age字段进行分组，可以使用MySQL的GROUP_CONCAT函数和JSON_ARRAY函数实现。具体的SQL语句如下所示：

```sql
Copy CodeSELECT age, CONCAT('[', GROUP_CONCAT(JSON_QUOTE(user_id)), ']') AS user_ids
FROM A
GROUP BY age;
```

在这条SQL语句中，先选择了age字段和使用GROUP_CONCAT函数连接使用JSON_QUOTE函数处理过的user_id，并在最终结果外包裹了一个中括号“[]”，使用CONCAT函数实现字符串拼接，将其命名为user_ids，然后根据age字段进行分组。

执行完这条SQL语句之后，会返回一个结果集，其中每一行代表一个分组，包含该分组的age值和该分组内的所有user_id，用JSON数组形式表示。