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

 <img src="C:\Users\32176\Desktop\expect项目总结\mysql\mysql命令\img\1.png" alt="image-20210608113128592" style="zoom: 67%;" />

### 创建数据库

```sql
create database 数据库名;
```



 <img src="C:\Users\32176\Desktop\expect项目总结\mysql\mysql命令\img\4.png" alt="image-20210608113914623" style="zoom:80%;" />

### 删除数据库

```sql
drop database 数据库名;
```

 <img src="C:\Users\32176\Desktop\expect项目总结\mysql\mysql命令\img\5.png" alt="image-20210608114107586" style="zoom:80%;" />

### 切换数据库（进入数据库）

```sql
use 数据库名
```

 <img src="C:\Users\32176\Desktop\expect项目总结\mysql\mysql命令\img\2.png" alt="image-20210608113514411" style="zoom:80%;" />

# 表相关

### 查看表

```sql
show tables;
```

 <img src="C:\Users\32176\Desktop\expect项目总结\mysql\mysql命令\img\3.png" alt="image-20210608113636309" style="zoom: 50%;" />

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

 <img src="C:\Users\32176\Desktop\expect项目总结\mysql\mysql命令\img\6.png" alt="image-20210608114532605" style="zoom:80%;" />



### 修改表结构



```sql
mysql> alter table tb_one modify runoob_title varchar(255) default null comment "标题";
Query OK, 0 rows affected (0.06 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql>
```

修改后

 <img src="C:\Users\32176\Desktop\expect项目总结\mysql\mysql命令\img\7.png" alt="image-20210608115955594" style="zoom:80%;" />

```sql
1.修改字段：一般修改属性和数据类型

alter table login_user modify password varchar(25) DEFAULT NULL COMMENT '密码2'

2.重命名字段：
alter table 表名 change 老字段   新字段  数据类型 [属性][位置]；

alter table login_user change password2  password varchar(26) DEFAULT NULL COMMENT '密码3'

3.新增字段：alter  table  表名  add [column]  字段名  数据类型  [列属性][位置]
位置：字段可以存放在表中的任意位置；
first：第一个位置；
after：在哪个字段之后；默认在最后一个字段的后面。

--添加到最后
alter  table  login_user  add   password3  varchar(26) DEFAULT NULL COMMENT '密码4'
--添加到指定字段后面  alter table + 表名 + add + 要添加的字段 字段类型 +  after  + 要跟随的字段名
alter  table  login_user  add   password6   varchar(26)  DEFAULT NULL COMMENT '密码6'  after password

4.删除字段：alter table 表名 drop 字段名；

alter  table  login_user  drop   password5
```

