### 连接数据库

```bash
mysql -h127.0.0.1 -P3306 -uroot -p

mysql  -h  主机名(ip)  -u  用户名 -P 端口 -p 

说明:

**-h:** 主机名，表示要连接的数据库的主机名或者IP

**-u:** 用户名，表示连接数据库的用户名

**-P:** 端口，表示要连接的数据库的端口，默认是3306，可以不写，但是如果端口不是默认端口，就必须指明端口号

**-p:** 表示要连接的数据库的密码，-p后面可以直接输入密码，但是这样密码就会明文输入不太安全，所以建议输入-p回车，换行输入密码
```

# 数据库相关

### 查看数据库

```sql
show databases;
```

 <img src=".\img\1.png" alt="image-20210608113128592" style="zoom: 67%;" />

### 创建数据库

```sql
create database 数据库名;
```



 <img src=".\img\4.png" alt="image-20210608113914623" style="zoom:80%;" />

### 删除数据库

```sql
drop database 数据库名;
```

 <img src=".\img\5.png" alt="image-20210608114107586" style="zoom:80%;" />

### 切换数据库（进入数据库）

```sql
use 数据库名
```

 <img src=".\img\2.png" alt="image-20210608113514411" style="zoom:80%;" />

# 表相关

### 查看表

```sql
show tables;
```

 <img src=".\img\3.png" alt="image-20210608113636309" style="zoom: 50%;" />

### 创建表

```sql
CREATE TABLE IF NOT EXISTS `tb_one`(
   `runoob_id` INT UNSIGNED AUTO_INCREMENT,
   `runoob_title` VARCHAR(100) NOT NULL,
   `runoob_author` VARCHAR(40) NOT NULL,
   `submission_date` DATE,
   PRIMARY KEY ( `runoob_id` )
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
```









### 查看表结构

```sql
desc 表名;
```

 <img src=".\img\6.png" alt="image-20210608114532605" style="zoom:80%;" />



### 修改表结构

在 MySQL 中，可以使用 ALTER TABLE 语句来修改表的结构。以下是几个常见的表结构修改操作及其对应的语法：

#### 添加新字段：

```mysql
ALTER TABLE 表名
ADD 列名 列类型;
```

例如，要在 `account_info` 表中添加一个名为 `phone` 的字段，可以执行以下语句：

```mysql
ALTER TABLE account_info
ADD phone varchar(20) NOT NULL DEFAULT '15515515155' COMMENT '手机号';
```

#### 修改字段的名称（）：

```mysql
ALTER TABLE 表名
CHANGE 旧列名 新列名 列类型;
```

假设要将 `phone` 字段更名为 `mobile`，可以执行以下语句：

```mysql
ALTER TABLE account_info
CHANGE phone mobile varchar(20);
```

#### 修改字段的数据类型（用来修改字段类型 、限制、默认值 等影响结构的）：

```mysql
ALTER TABLE 表名
MODIFY COLUMN 列名 新列类型;
```

如果要将 `phone` 字段的数据类型更改为 `TEXT`，可以执行以下语句：

```mysql
ALTER TABLE account_info
MODIFY COLUMN phone TEXT;
```

#### 删除字段：

```mysql
ALTER TABLE 表名
DROP COLUMN 列名;
```

例如，要删除 `phone` 字段，可以执行以下语句：

```mysql
ALTER TABLE account_info
DROP COLUMN phone;
```

**请注意，在执行 ALTER TABLE 语句之前，请确保没有正在进行的事务和会话，并且对表的修改操作不会导致数据丢失或破坏表结构。同时，在生产环境中进行表结构的修改前，请先在测试环境中验证和测试相应的 SQL 语句，以确保修改不会引发意外问题。**