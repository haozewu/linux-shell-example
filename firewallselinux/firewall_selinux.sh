#!/bin/bash





firewallselinux_close()
{
	service iptables stop
	chkconfig iptables off
	
}