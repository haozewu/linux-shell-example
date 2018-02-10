#!/bin/bash
source ./head.sh

	#start nat mode service before in vmware in school
	if [$network_config -eq yes]
		then
		source network/network_config.sh
		#only have centos6.5 and ubuntu 16.04, test ubuntu16.04, don't work, next config and test the network successfully
		network_config($system)
	fi





























