nginx指定文件路径有两种方式root和alias，指令的使用方法和作用域：

[root]

语法：root path

默认值：root html

配置段：http、server、location、if

[alias]

语法：alias path

配置段：location

root与alias主要区别在于nginx如何解释location后面的uri，这会使两者分别以不同的方式将请求映射到服务器文件上。

**root的处理结果是**：root路径＋location路径

**alias的处理结果是**：使用alias路径替换location路径

alias是一个目录别名的定义，root则是最上层目录的定义。

还有一个重要的区别是alias后面必须要用“/”结束，否则会找不到文件的。。。而root则可有可无~~

