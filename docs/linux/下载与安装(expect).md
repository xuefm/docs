# 1.[centos官网](https://www.centos.org/)

## centos7几种版本x86_64、aarch64、armhfp、i386、power9、ppc64、ppc64el简单说明

一直用的**x86_64**的系统，今天去找一个ARM架构的centos，看到这么多版本，一脸懵逼，通过sc大概总结了一点说明，请参考：

以centos7的iso下载位链接http://isoredirect.centos.org/centos/7/isos/

| url                                                   | images                                  |
| ----------------------------------------------------- | --------------------------------------- |
| http://isoredirect.centos.org/centos/7/isos/x86_64/   | for CentOS 7 x86_64 iso images          |
| http://isoredirect.centos.org/altarch/7/isos/aarch64/ | for CentOS 7 AltArch AArch64 iso images |
| http://isoredirect.centos.org/altarch/7/isos/armhfp/  | for CentOS 7 AltArch armhfp disk images |
| http://isoredirect.centos.org/altarch/7/isos/i386/    | for CentOS 7 AltArch i386 iso images    |
| http://isoredirect.centos.org/altarch/7/isos/power9/  | for CentOS 7 AltArch POWER9 iso images  |
| http://isoredirect.centos.org/altarch/7/isos/ppc64/   | for CentOS 7 AltArch ppc64 iso images   |
| http://isoredirect.centos.org/altarch/7/isos/ppc64le/ | for CentOS 7 AltArch ppc64le iso images |


x86_64 我们常说的主流的64位架构，代表厂家有Intel、AMD

altarch 个人理解我其他架构，除了x86_64以外的其他CPU架构，centos把支持的每个版本单独拎出来，这样看起来一个很庞大的系列：

aarch64 就是arm架构的64位系统，基于armv8指令集的64位架构，应该是后续ARM主流商用服务器的标准

armhfp 主要是对armv7hl兼容，支持基于arm的一系列单板计算机和嵌入式设备

i386 就是已经即将被淘汰的x86的以奔腾系列位代表的32位架构

后面3种都是IMb的power系列：

power9 对应IBM的power9架构cpu

ppc64  IBM power系列架构，目标架构为64位PowerPC和Power Architecture处理器，并对此优化的应用程序的标识符，编译源代码时经常使用

ppc64el 纯小端模式，POWER8作为首要目标，OpenPower基金会基础的技术，试图使基于x86的Linux软件的移植工作以最小的工作量进行



## CentOS LiveCD、LiveDVD、BinDVD、netinstall、minimal版区别在哪里

BinDVD版——就是普通安装版，需安装到计算机硬盘才能用，bin一般都比较大，而且包含大量的常用软件，安装时无需再在线下载（大部分情况）。 

**minimal**版——这个镜像文件用于安装一个非常基本的 CentOS系统,包含了一些基本所需的最小安装包。

netinstall版——用于网络安装和系统救援的镜像文件。

LiveDVD版——就是一个光盘CentOS系统，可通过光盘启动电脑，启动出CentOS系统，也有图形界面，也有终端。也可以安装到计算机，但是有些内容可能还需要再次到网站下载（自动）。 
LiveCD版——相比LiveDVD是个精简的光盘CentOS系统。体积更小，便于维护使用。

#### 使用x86_64就行了

阿里云镜像地址

```url
http://mirrors.aliyun.com/centos/7.9.2009/isos/x86_64/
```

