#!/bin/bash
source ../head.sh

#network card config manual
ubuntu_network_config(){
	echo -e auto eth0\niface eth0 inet static\naddress $ip\nnetmask $netmask\ngateway $gateway\ndns-nameserver $dns
	#reboot
	
	#hostname $hostName
	#echo -e 127.0.0.1"\t"localhost"\n"$ip"\t"$hostName"\n"::1"\t"localhost"\t"ip6-localhost"\t"ip6-loopback"\n"ff02::1"\t"ip6-allnodes"\n"ff02::2"\t"ip6-allrouters > /etc/hosts
}

centos6_network_config(){
	sed -i "s#BOOTPROTO=\"dhcp\"#BOOTPROTO=static#g" /etc/sysconfig/network-scripts/ifcfg-eth0
	sed -i "s#IPV6INIT=\"yes\"#IPV6INIT=no#g" /etc/sysconfig/network-scripts/ifcfg-eth0
	echo -e "\nBOOTPROTO=static\nONBOOT=yes\nIPADDR=$ip\nNETMASK=$netmask\nGATEWAY=$gateway\nDNS1=$dns\nIPV6INIT=no" >> /etc/sysconfig/network-scripts/ifcfg-eth0
	service ip6tables stop
	chkconfig ip6tables off
	service network restart
	ifconfig
}

centos7_network_config(){
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

network_config()
{
	case $1 in
		centos6 ) centos6_network_config
		;;
		centos7 ) centos7_network_config
		;;
		ubuntu ) ubuntu_network_config
	esac
}

