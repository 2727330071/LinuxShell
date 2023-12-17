#!/bin/bash
yum_ins () {
echo '
[AppStream]
name=AppStream
baseurl=file:///mydvd/AppStream
enabled=1
gpgcheck=0

[BaseOS]
name=BaseOS
baseurl=file:///mydvd/BaseOS
enabled=1
gpgcheck=0' > /etc/yum.repos.d/rocky.repo
	}

#判断是否是管理员权限
if [ $UID == 0 ] ; then
	if [ -d /etc/yum.repos.d/bck ] ; then
		echo "存在备份路径，开始写入yum仓库"
		mv /etc/yum.repos.d/[rR]ocky* /etc/yum.repos.d/bck
		yum_ins
		yum repoinfo
	else
		echo "不存在备份路径，开始创建备份目录，并写入yum仓库"
		mkdir /etc/yum.repos.d/
		mv /etc/yum.repos.d/[rR]ocky* /etc/yum.repos.d/bck
		yum_ins
		yum repoinfo
	fi
else
	echo "请使用管理员权限" && exit
fi
