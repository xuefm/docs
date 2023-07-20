#!/bin/bash


#老文件备份名
dd=`date +%Y-%m-%d-%H-%M-%S`

#工作目录
work_dir=/opt/java
#备份目录
backups_dir=/opt/java/backups

#日志
log_file=/root/updateService.log

#保存备份个数，备份31天数据
number=10

#保证文件存在
if [[ -e $work_dir/app.jar && -e $work_dir/supply-chain-dev.jar ]]
then
        echo "开始更新系统"
	#备份老文件
	echo "备份老文件"
	mv $work_dir/app.jar $backups_dir/$dd.jar
	#新文件改名
	echo "新文件改名"
	mv $work_dir/supply-chain-dev.jar $work_dir/app.jar

	#判断现在的备份数量是否大于$number
	count=`ls -l -crt $backups_dir/*.jar | awk '{print $9 }' | wc -l`

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
	docker restart  supply-chain-service
	echo "打印日志"
	docker logs -f  --tail 200 supply-chain-service
else
        echo "条件不满足"
fi
