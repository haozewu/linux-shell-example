#your system
system='centos6'

######################change network######################
network_config=0
#start from 128 to 254
ip=192.168.254.130
netmask=255.255.255.0
#mac=00:0C:29:03:F3:76
dns=192.168.254.2
#hostName=master
gateway=192.168.254.2
#ethname=ens33

#close iptables4

#######################user_manager#######################

user_manager=0

#adduser
adduser=0
adduser_name=6789

#deluser
userdel=0
userdel_name=12345

######################software install####################
#install?
if_install=1

install_python27=1




