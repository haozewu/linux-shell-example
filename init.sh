#!/bin/bash

#---------------result-----------------#

#after that, copy the last node's /etc/hosts to others

#real ip, master and node ok


#----------------all-------------------#

#run by root

#if 0, master
#if 1, node1
#if 2, node2
#...
setto=1

userName=wu

#if 1, real
#if 0, virsul
isreal=1

#config /etc/hosts
masterip=192.168.1.195
nodeip1=192.168.1.194
nodeip2=192.168.1.255
nodeip3=192.168.1.
nodeip4=192.168.1.
nodeip5=192.168.1.
nodeip6=192.168.1.


#---------------real environment-------------#

#---------------virsul environment------------#

if [ $isreal -eq 0 ]
then
	netmask=255.255.255.0
	dns=192.168.183.2
	gateway=192.168.183.2
fi
if [ $setto -eq 0 ]
then
	#change hostname
	hostName=master
else
	hostName=node$setto
	node=hostName
fi

centos6_init_conf(){
	#set close selinux
	#explain: # is nomally /; g means for a whole file
	sed -i "s#SELINUX=enforcing#SELINUX=disabled#g" /etc/selinux/config
	echo -e "$userName\tALL=(ALL)\tALL" >> /etc/sudoers
}
centos6_sethostname(){
	echo -e "\n$masterip\tmaster" >> /etc/hosts
	if [ $setto -gt 0 ]
	then
		nodeeach=1
		while(($nodeeach<=$setto))
		do
			#-n means do not enter after echo
			eval echo -n "\$nodeip$nodeeach" >> /etc/hosts
			echo -e "\tnode$nodeeach" >> /etc/hosts
			let "nodeeach++"
		done
	fi
	hostname $hostName
	echo -e "NETWORKING=yes\nHOSTNAME=$hostName" > /etc/sysconfig/network
}
centos6_network(){

	if [ $isreal -eq 0 ]
	then
		sed -i "s#BOOTPROTO=\"dhcp\"#BOOTPROTO=static#g" /etc/sysconfig/network-scripts/ifcfg-eth0
		sed -i "s#IPV6INIT=\"yes\"#IPV6INIT=no#g" /etc/sysconfig/network-scripts/ifcfg-eth0
		echo -e "\nIPADDR=$ip\nNETMASK=$netmask\nGATEWAY=$gateway\nDNS1=$dns" >> /etc/sysconfig/network-scripts/ifcfg-eth0
		service network restart
	fi
	#stop iptables
	service iptables stop
	chkconfig iptables off
	ifconfig
}
centos6_ssh_pre_all(){
	echo -e "\nRSAAuthentication yes\nPubkeyAuthentication yes\nAuthorizedKeysFile .ssh/authorized_keys" >> /etc/ssh/sshd_config
	chmod 700 /home/$userName
	chmod 700 /home/$userName/.ssh
	#install expect
	yum install -y expect
}
centos6_settime(){
	cat /usr/share/zoneinfo/Asia/Shanghai > /etc/localtime
	yum install -y ntpdate
	ntpdate time.windows.com
 	hwclock -w
}
centos6_init_conf
centos6_sethostname
centos6_network
centos6_ssh_pre_all
centos6_settime
reboot
