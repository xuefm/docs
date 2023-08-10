## 1.`docker`容器`jar`包更新并备份

```shell
#!/bin/bash


#老文件备份名
dd=`date +%Y-%m-%d-%H-%M-%S`

#工作目录
work_dir=/opt/java
#备份目录
backups_dir=/opt/java/backups

#新文件
new_file=$work_dir/supply-chain-dev.jar

#日志
log_file=/root/updateService/updateService.log

#保存备份个数，备份31天数据
number=31

#docker容器
docker_container=supply-chain-service

#保证文件存在
if [[ -e $work_dir/app.jar && -e $new_file ]]
then
        echo "开始更新系统"
	#备份老文件
	echo "备份老文件"
	mv $work_dir/app.jar $backups_dir/$dd.jar
	#新文件改名
	echo "新文件改名"
	mv $new_file $work_dir/app.jar

	#判断现在的备份数量是否大于$number
	count=`ls -l -crt $backups_dir/*.jar | wc -l`

	if [ $count -gt $number ]
	then
		#找出需要删除的备份
        	delfile=`ls -l -crt $backups_dir/*.jar | awk '{print $9 }' | head -1`
        	#删除最早生成的备份，只保留number数量的备份
        	rm $delfile
        	#写删除文件日志
		echo "删除文件: ${delfile}"
		echo "$(date "+%Y-%m-%d %H:%M:%S") 删除文件: ${delfile}">>${log_file}
fi


	echo "重启系统"
	docker restart  ${docker_container}
	echo "打印日志"
	docker logs -f  --tail 200 ${docker_container}
else
        echo "条件不满足"
fi
```



## 2.回滚（与1配合使用）

```shell
#!/bin/bash

#工作目录
work_dir=/opt/java
#备份目录
backups_dir=/opt/java/backups
#日志文件
log_file=/root/rollback.log
#docker容器
docker_container=supply-chain-service


old_file=${backups_dir}/$(ls -Art $backups_dir | tail -n 1)
echo "$(date "+%Y-%m-%d %H:%M:%S")删除当前文件${work_dir}/app.jar"
echo "$(date "+%Y-%m-%d %H:%M:%S")删除当前文件${work_dir}/app.jar">>${log_file}
rm -f $work_dir/app.jar
echo "$(date "+%Y-%m-%d %H:%M:%S")复制文件${old_file}到${work_dir}/app.jar"
echo "$(date "+%Y-%m-%d %H:%M:%S")复制文件${old_file}到${work_dir}/app.jar">>${log_file}
cp $backups_dir/$(ls -Art $backups_dir | tail -n 1) /opt/java/app.jar
echo "$(date "+%Y-%m-%d %H:%M:%S")重新启动服务"
echo "$(date "+%Y-%m-%d %H:%M:%S")重新启动服务">>${log_file}
docker restart ${docker_container}
echo "$(date "+%Y-%m-%d %H:%M:%S")查看日志"
docker logs -f --tail 200 ${docker_container}
```



## 3.http健康检测

```shell
#!/bin/bash

#日志保存位置
log_url=/root/heartbeat.log
#异常日志位置
error_log_url=/root/heartbeat_error.log

#请求地址
url=http://127.0.0.1:8080/tdd/v1/heartbeat/inspection
#请求超时时间 单位秒
time_out=3 
#请求间隔时间 单位秒
interval_time=60
#系统准备时间 单位秒
readiness_time=120
#docker容器
docker_container=supply-chain-service
while true
do
        resp=$(curl -i -m ${time_out} -o /dev/null -s -w %{http_code} $url)
        if test $resp -ge 200 && test $resp -le 399
        then
                echo "$(date "+%Y-%m-%d %H:%M:%S") ${url} successful" >> ${log_url}
                sleep ${interval_time}s
        else
                echo "$(date "+%Y-%m-%d %H:%M:%S") ${url} failed" >> ${log_url}
                echo "$(date "+%Y-%m-%d %H:%M:%S") ${url} failed" >> ${error_log_url}
                echo "$(date "+%Y-%m-%d %H:%M:%S") 重启系统" >> ${log_url}
                echo "$(date "+%Y-%m-%d %H:%M:%S") 重启系统" >> ${error_log_url}
                docker restart ${docker_container}
                sleep ${readiness_time}s
        fi

done
```

3.1使用 `nohup` 命令：`nohup` 命令可以忽略挂起信号（SIGHUP），允许程序在终端关闭后继续在后台运行。

使用 `nohup` 会生成一个 `nohup.out `文件,该文件会保存执行中的输出

```bash
nohup xxx.sh &
```



