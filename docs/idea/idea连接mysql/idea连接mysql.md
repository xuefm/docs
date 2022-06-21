![img](img\1.png)

![img](img\2.png)



**IDEA连接mysql又报错！Server returns invalid timezone. Go to 'Advanced' tab and set 'serverTimezone' prope**

前进的道路充满荆棘。

### 错误界面

IDEA连接mysql，地址，用户名，密码，数据库名，全都配置好了，点测试连接，咔！不成功！

界面是这样的，

![img](img\3.png)



翻译过来就是：服务器返回无效时区。进入“高级”选项卡，手动设置“serverTimezone”属性。

看起来是时区出了问题。时区怎么会出问题？坑真多。网上搜了各种解决办法，琳琅满目，复杂的简单的，总算是解决了！

# 解决方案

**我的问题出在两块，第一，设置mysql的时区。第二，mysql驱动的版本。详细步骤如下：**





### 第一，设置mysql时区。

**1，我们先来检查下mysql时区。**

**(  这里有个小插曲~~~你的mysql，配置好环境变量了吗 ）**

![img](img\4.png)



配置完环境变量，就可以在命令窗口直接执行下面的命令啦！

进入命令窗口（Win + R），连接数据库 **mysql -hlocalhost -uroot -p**，回车，输入密码，回车，如图：

![img](img\5.png)

2，继续输入 **show variables like'%time_zone';**    （注意不要漏掉后面的分号），回车，如图：

![img](img\6.png)

显示 SYSTEM 就是没有设置时区啦。

3，现在我们来设置时区。

输入**set global time_zone = '+8:00';**  注意不要漏掉后面的分号），回车，如图：

![img](img\7.png)

这便是设置成功啦！

这时你重新连接下数据库，也许能连接成功！如果没有，就继续往下走！

### 第二，同步mysql驱动。

我本机安装的mysql版本是5.7的，那么IDEA要连接mysql也应该匹配下驱动版本。把Driver改成MySQL for 5.1就可以了

![img](img\8.png)

在点击Test Connection测试下，成功啦！

![img](img\9.png)

【补充】

如果，你选的是MySQL，

数据库又是其他版本的，也没关系。

在驱动列表里找到 MySQL ，右边Driver files 里，选择一下你需要的版本，保存就可以了。

![img](img\10.png)

————————————————
版权声明：本文为CSDN博主「liuqiker」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/liuqiker/article/details/102455077