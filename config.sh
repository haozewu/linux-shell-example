#!/bin/bash

#segmentation fault:command confliction

#find . -type f -exec dos2unix {} \;
#to change code by one command

#debug:
#	centos6.9:
#		run by root
#		network_config
#		vsftpd

#log
#	adduser ok
#	deluser ok
#	install_python27 may have something wrong with sed



source ./head.sh


#start nat mode service before in vmware in school
if [[ $network_config -eq 1 ]]; then
	source ./network/network_config.sh
	#only have centos6.5 and ubuntu 16.04, test ubuntu16.04, don't work, next config and test the network successfully
	network_config $system
fi
#if install software
if [[ $user_manager -eq 1 ]];	then
	#find all users
	#cat /etc/passwd | cut -f 1 -d :
	if [[ $adduser -eq 1 ]]; then
		#adduser $adduser_name : segmentation fault
		source ./user/user_manager.sh
		add_user $adduser_name
	fi
	if [[ $userdel -eq 1 ]]; then
		userdel $userdel_name
	fi
fi
#if install software
if [[ $if_install -eq 1 ]]; then
	source ./software/software_install.sh
	if [[ $install_python27 -eq 1 ]]; then
		install_python27 $system
	fi
fi



























