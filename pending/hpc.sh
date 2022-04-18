#!/bin/bash

#--------------------result--------------------#




#--------------------all-----------------------#


#run by normal user

#if 0, set master
#if 1, set node
setto=1

centos6_ssh_master(){
	/usr/bin/expect << EOF
	set timeout -1
	spawn ssh-keygen -t rsa
	expect ".ssh/id_rsa):"
	send "\r"
	expect "(empty for no passphrase):"
	send "\r"
	expect "again:"
	send "\r"
	expect eof
EOF

	#echo '1' | sudo -S service sshd restart
	cat /home/wu/.ssh/id_rsa.pub >> /home/wu/.ssh/authorized_keys
}
centos6_ssh_node(){
	/usr/bin/expect << EOF
	set timeout -1
	spawn ssh-keygen -t rsa
	expect ".ssh/id_rsa):"
	send "\r"
	expect "(empty for no passphrase):"
	send "\r"
	expect "again:"
	send "\r"
	expect eof
EOF


	echo '1' | sudo -S service sshd restart
	
	#----------------------------------------------此处需要优化，expect------------------------------------------#
	#ssh-copy-id wu@master
	/usr/bin/expect << EOF
	set timeout -1
	spawn ssh-copy-id wu@master
	expect "connecting (yes/no)?"
	send "yes\r"
	expect "s password:"
	send "1\r"
	expect eof
EOF
	/usr/bin/expect << EOF
	set timeout -1
	spawn ssh master
	expect "s password:"
	send "1\r"
	send "sudo scp /home/wu/.ssh/authorized_keys node1:/home/wu/.ssh/\r"
	expect "password for wu:"
	send "1\r"
	expect "(yes/no)?"
	send "yes\r"
	expect "s password:"
	send "1\r"
	send "logout\r"
	expect eof
EOF
}
centos6_nfs_master(){
	#NFS config
	#the following run in manage node
	#mkdir /home
	#sudo chmod -R 777 /home/wu/share
	echo '1' | sudo -S yum -y install nfs-utils  rpcbind
	
	touch /home/wu/exports

	echo '/home/ *(rw,insecure,no_root_squash,sync)' >> /home/wu/exports

	echo '1' | sudo -S sudo cp /home/wu/exports /etc/
	rm -rf /home/wu/exports
	#start nfs
	echo '1' | sudo -S service rpcbind restart
	echo '1' | sudo -S service nfs restart
	#look nfs status
	echo '1' | sudo -S service nfs status
	#RPC必须先于NFS启动，这样NFS才可以向RPC注册
	echo '1' | sudo -S chkconfig nfs off
	echo '1' | sudo -S chkconfig rpcbind on
	echo '1' | sudo -S chkconfig nfs on
	#systemctl enablenfs.service
}
centos6_nfs_node(){
	#NFS config
	#the following run in manage node
	#mkdir /home
	
	#echo '1' | sudo -S rm -rf /home/*
	
	#sudo chmod -R 777 /home
	
	echo '1' | sudo -S yum -y install nfs-utils
	#  rpcbind
	#start nfs
	#service rpcbind start
	echo '1' | sudo -S service rpcbind restart
	echo '1' | sudo -S service nfs restart
	#look nfs status
	echo '1' | sudo -S service nfs status
	#RPC必须先于NFS启动，这样NFS才可以向RPC注册
	echo '1' | sudo -S chkconfig nfs off
	echo '1' | sudo -S chkconfig rpcbind on
	echo '1' | sudo -S chkconfig nfs on
	#systemctl enablenfs.service
	echo '1' | sudo -S mount -t nfs master:/home/ /home/ -o proto=tcp -o nolock

}
centos6_mpi_master(){
	cd /home/wu
	mkdir software
	cd software
	wget http://www.mpich.org/static/downloads/3.2.1/mpich-3.2.1.tar.gz
	#mkdir /home/wu/software
	#cp /home/wu/share/mpich-3.2.1.tar.gz /home/wu/software/
	#cd /home/wu/software/
	tar -zxvf /home/wu/software/mpich-3.2.1.tar.gz
	echo '1' | sudo -S yum -y install gcc-c++
	cd /home/wu/software/mpich-3.2.1/
	./configure --disable-fortran
	make
	echo '1' | sudo -S make install
}


if [ $setto -eq 0 ]
then
	centos6_ssh_master
	centos6_nfs_master
	#centos6_mpi_master
else
	#centos6_ssh_node
	centos6_nfs_node
	#centos6_mpi
fi

























#centos6_nis_master(){
#	#set on-line yum source
#	echo -e "[Centos6]\nname=Centos6X\nbaseurl=http://mirrors.vbi.vt.edu/linux/rhel/6.5/\nenabled=1\ngpgcheck=0" > /etc/yum.repos.d/local_yum_fornis.repo
#	#there are no protmap ypser in the source ahead
#	yum install ypserv yp-tool ypbind -y
#	echo -e "\nNISDOMAIN=haoze" >> /etc/sysconfig/network
#	#wget http://www.linux-nis.org/download/yp-tools/yp-tools-4.2.2.tar.bz2
#	#tar -jxvf yp-tools-4.2.2.tar.bz2
#	#bind failed!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#	#authconfig-gtk
#	#or authconfig-tui
#	#绑定nis服务失败，检查服务端selinu模式和iptables状态，关掉iptables，selinux设置为警告模式。
#	#vi /etc/selinux/config，设置SELINUX=disabled    then restart
#	chkconfig ypserv on
#	chkconfig yppasswdd on
#	#haoze is domain of nis
#	nisdomainname haoze
#	echo 'nisdomainname haoze' >> /etc/rc.d/rc.local
#	service ypserv restart
#	service yppasswdd restart
#	rpcinfo -u master ypserv
#	#two process
#	/usr/lib64/yp/ypinit -m
#	#or /usr/lib/yp/ypinit -m
#	#will see admin has been set up as a NISserver ,now you can run ypinit –s admin on all slave server.     if ok
#	#在server端重新建立新用户后，需要到/var/yp 目录下make一下(当nis map有任何修改必须重新make一下)，这样client端才能使用新用户登录。
##
##	not do that
##	5、设置Master 和Slave数据库同步 
##NIS可以通过pypush可以直接将master上的数据库同步到Slave节点上。#
##vim /var/yp/Makefile
##NOPUSH=true 改为false
##1
##2
##然后在执行命令：#
##yppush -h pnode3 passwd.byname
##yppush -h pnode3 passwd.byuid
#}
#centos6_nis_node(){
#	#yum install -y ypserv yp-tool ypbind
#	#authconfig-gtk
#	#domain haoze
#	#ip master
#	#or 也可以直接修改/etc/yp.conf文件来设定nis  client端
#	echo -e "[Centos6]\nname=Centos6X\nbaseurl=http://mirrors.vbi.vt.edu/linux/rhel/6.5/\nenabled=1\ngpgcheck=0" > /etc/yum.repos.d/local_yum_fornis.repo
#	echo -e "\nNISDOMAIN=haoze" >> /etc/sysconfig/network
#	#there are no protmap ypser in the source ahead
#	yum install yp-tool ypbind -y
#	echo -e "\nnisdomainname master" >> /etc/rc.d/rc.local
#	echo -e "domain haoze\nserver master" > /etc/yp.conf
#	service ypserv restart
#	service ypbind restart
##chkconfig ypserv on
##	chkconfig yppasswdd on
##	service yppasswdd restart
##	service ypserv restart
##	nisdomainname haoze
##	echo “/bin/nisdomainname” >> /etc/rc.d/rc.local
##	/usr/lib64/yp/ypinit -s master
##	ypcat -h localhost passwd.byname
#	#what's wrong??????????????????????????????????????????????????
#}
#centos6_tentakel(){
#	 wget https://sourceforge.net/projects/tentakel/files/latest/download?source=typ_redirect --no-check-certificate
#	 tar -zvxf tentakel-2.2.tgz 
#	 cd tentakel-2.2
#	 make
#	 make install
#	 cp tentakel.conf.example /etc/tentakel.conf
#	 cp -r ./py/lekatnet /usr/lib/python2.6/site-packages/
#	 cp -r ./py/lekatnet /usr/lib64/python2.6/site-packages/
#	 tentakel -l
#	 #fuck!!!!!!!!!!!!!!!!!!
#}
#





