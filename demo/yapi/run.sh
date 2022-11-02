#!/bin/bash

# 判断文件夹是否存在，存在则说明已经部署过了，直接运行服务
if [ -f "/my-yapi/vendors/server/app.js" ];then
	# 正常运行服务
	node /my-yapi/vendors/server/app.js
else
	# 初次部署使用以下命令
	yapi server
fi