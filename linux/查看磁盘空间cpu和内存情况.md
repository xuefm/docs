# 查看磁盘空间(查看硬盘占用)

```bash
#查看磁盘空间大小
df -h

#查看当前文件夹所有文件大小
du -sh

#查看指定文件夹大小
du -h /data

#查看指定文件夹下所有文件的大小
du -h /data/

#查看指定文件大小
du -h data.log查看目录挂载点df /data加上-kh以g单位显示df /data -kh
```

查看cpu

top

查看内存

free -h