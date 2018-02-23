#!/bin/bash

centos6_vsftpd_install()
{
	#注意：selinux和iptables都会影响到ftp正常工作
	#/etc/vsftpd/vsftpd.conf
	#anonymous_enable=NO  # 是否开启匿名登录
	#local_enable=YES   # 是否允许本地用户登录
	#write_enable=YES  # 是否允许上传
	#local_umask=022   # 默认的umask码
	#diremssage_enable=YES  # 是否显示目录说明文件
	#xferlog_enable=YES  # 是否记录ftp传输过程
	#connect_from_prot_20=YES # 是否确定端口传输来自20
	#xferlog_std_format=YES   # 是否使用标准的ftp xferlog模式
	#chroot_list_enable=YES  # 是否将系统用户限制在自己的home目录下
	#chroot_list_file=/etc/vsftpd/chroot_list#列表不受限制的用户，不受限制用户，不受限制用户
	#listen=YES   # 是否开启监听
	#pam_service_name=vsftpd # 服务名称
	#userlist_enable=YES
	#tcp_wrappers=YES



	#
	yum install -y vsftpd
	chkconfig vsftpd on
	sed -i "s#anonymous_enable=YES#anonymous_enable=NO#g" /etc/vsftpd/vsftpd.conf
	sed -i "s#\#chroot_list_file=/etc/vsftpd/chroot_list#chroot_list_file=/etc/vsftpd/chroot_list#g" /etc/vsftpd/vsftpd.conf

}
vsftpd_install()
{
	case $1 in
		centos6 )	centos6_vsftpd_install
		;;

	esac
}
