#!/bin/bash

#工作目录
work_dir=/opt/java
#备份目录
backups_dir=/opt/java/backups
#日志文件
log_file=/root/rollback.log
old_file=${backups_dir}/$(ls -Art $backups_dir | tail -n 1)
echo "$(date "+%Y-%m-%d %H:%M:%S")删除当前文件${work_dir}/app.jar"
echo "$(date "+%Y-%m-%d %H:%M:%S")删除当前文件${work_dir}/app.jar">>${log_file}
rm -f $work_dir/app.jar
echo "$(date "+%Y-%m-%d %H:%M:%S")复制文件${old_file}到${work_dir}/app.jar"
echo "$(date "+%Y-%m-%d %H:%M:%S")复制文件${old_file}到${work_dir}/app.jar">>${log_file}
cp $backups_dir/$(ls -Art $backups_dir | tail -n 1) /opt/java/app.jar
echo "$(date "+%Y-%m-%d %H:%M:%S")重新启动服务"
echo "$(date "+%Y-%m-%d %H:%M:%S")重新启动服务">>${log_file}
docker restart supply-chain-service
echo "$(date "+%Y-%m-%d %H:%M:%S")查看日志"
docker logs -f --tail 200 supply-chain-service 
