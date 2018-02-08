#!/bin/bash




#start vmware service first!!!!!if in vmware

#centos 6.5:
	#/etc/sysconfig/network-scripts/ifcfg-eth0
	#del IPV6INIT
	#del BOOTPROTO
	#del ONBOOT





#all
#start from 128 to 254
ip=192.168.183.130
netmask=255.255.255.0
#mac=00:0C:29:03:F3:76
dns=192.168.183.2
hostName=master
gateway=192.168.183.2
#ethname=ens33



#don't works well
ubuntu(){
	echo auto lo"\n"iface lo inet loopback"\n"auto eth0"\n"iface eth0"\n"inet static"\n""\t"address"\t"$ip"\n""\t"netmask"\t"$netmask"\n""\t"gateway"\t"$gateway > /etc/network/interface

	#change DNS
	#echo nameserver $dns > /etc/resolvconf/resolv.conf.d/base
	sudo service networking restart

	hostname $hostName
	echo -e 127.0.0.1"\t"localhost"\n"$ip"\t"$hostName"\n"::1"\t"localhost"\t"ip6-localhost"\t"ip6-loopback"\n"ff02::1"\t"ip6-allnodes"\n"ff02::2"\t"ip6-allrouters > /etc/hosts
}



centos6(){
	#ifconfig $ethname $ip netmask $netmask
	#ifdown $ethname
	#ifconfig $ethname hw ether $mac
	#ifup $ethname
	#echo "$ip $mac" >> /etc/ethers
	#arp -f

	#echo ONBOOT=yes > /etc/sysconfig/network-scripts/ifcfg-eth0
	#service network restart
	#service NetworkManager stop
	#chkconfig NetworkManager off
	echo -e "\nBOOTPROTO=static\nONBOOT=yes\nIPADDR=$ip\nNETMASK=$netmask\nGATEWAY=$gateway\nDNS1=$dns\nIPV6INIT=no" >> /etc/sysconfig/network-scripts/ifcfg-eth0
	#stop ipv6 and don't let start
	service ip6tables stop
	chkconfig ip6tables off



	service network restart
	ifconfig
}



#the following do not works well
centos7(){
	nmcli connection modify $ethname \
	connection.autoconnect yes \
	ipv4.method manual \
	ipv4.address	$ip \
	ipv4.gateway	$gateway \
	ipv4.dns $dns
	#autoconnect  connect when start
	#ipv4.method  setup method
	systemctl restart network
	nmcli connection show $ethname
	hostnamectl set-hostname $hostName
}
centos6

