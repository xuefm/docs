## 1、create table -- 新建表

```sql
create table 表名(
字段名1 类型[(宽度) 约束条件],
字段名2 类型[(宽度) 约束条件],
字段名3 类型[(宽度) 约束条件]
);

# 在同一张表中，字段名是不能相同的
# 宽度和约束条件是可以选择的
# 字段名和类型是必须要有的
```

## 2、drop table -- 删除表

```sql
drop table 表名;
```

## 3、desc 表名 -- 查看表结构

```sql
# 查看表结构有两种方式：
describe 表名;这种方法和desc 表名;效果相同；可以查看当前的表结构

虽然desc命令可以查看表的定义，但是其输出的信息还不够全面，为了得到更全面的表定义信息，有时候就需要查看创建表的SQL语句，使用 show create table 语法。除了可以看到表定义之外，还可以看到engine（存储引擎）和charset（字符集）等信息。（\G选项的含义是是的记录能够竖向排列，以便更好的显示内容较长的记录。）
```

## 4、alter table -- 修改表

#### (1)、 alter table 表名 rename 新表名; --- 修改表名

```sql
alter table test rename staff;
```

#### (2)、alter table 表名 charset 编码; --- 修改表的编码方式

```sql
alter table test charset utf8;
```

#### (3)、alter table 表名 auto_increment 自增的位置; --- 修改表的自增值

```sql
alter table test auto_increment = 10;
```

#### (4)、alter table 表名 add 字段名 类型(长度) 约束; --- 增加字段

```sql
alter table test add sex enum('male','female');
```

#### (5)、 alter table 表名 drop 字段名; --- 删除字段

```sql
alter table test drop sex;
```

#### (6)、 alter table 表名 change 字段名 新名字 类型(长度) 约束； --- 修改字段名

```sql
alter table test change name sname varchar(20);
```

#### (7)、 alter table 表名 modify 字段名 新类型(新长度) 约束; --- 修改字段类型

```sql
alter table test modify id int(4);
```

#### (8)、 alter table 表名 change 旧字段名 新字段名 类型(长度) 约束 frist; -- 修改字段的排列顺序为第一个

```sql
alter table test change sex sex enum('male','female') first;
```

#### (9)、 alter table 表名 change 旧字段名 新字段名 类型(长度) 约束 after 字段; --- 修改字段的排列顺序为在字段后面

```sql
alter table test change sex sex enum('male','female') after sname;
```

#### (10)、alter table 表名 add 字段名 类型(长度) 约束 frist; --- 添加一个字段位置在第一个

```sql
alter table test add age int first;
```

#### (11)、 alter table 表名 add 字段名 类型(长度) 约束 after 字段; --- 添加一个字段在name字段后

```sql
alter table test add hobby char(22) after cname;
```

