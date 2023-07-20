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
interval_time=30
#系统准备时间 单位秒
readiness_time=60
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
		docker restart supply-chain-service 
		sleep ${readiness_time}s	
	fi

done



