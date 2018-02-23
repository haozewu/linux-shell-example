#!/bin/bash

install_python27()
{
	#zlib
	#openssl
	#setuptools
	#pip
	#sqlite3
	if [[ $1 -eq 'centos6' ]]; then
		wget https://www.python.org/ftp/python/2.7.14/Python-2.7.14.tar.xz
		tar -Jxvf  Python-2.7.14.tar.xz
		cd Python-2.7.14
		./configure --with-zlib=/usr/include
		make
		make install
		cd ..
		rm -rf Python-2.7.14
		rm -rf Python-2.7.14.tar

		#note:yum should run in python26,so config the yum configuration
		#sed -i "s/#!\/usr\/bin\/python/#!\/usr\/bin\/python2.6/g" /usr/bin/yum
		
		#wget https://bootstrap.pypa.io/get-pip.py
		#need tools to run get-pip

		wget https://pypi.python.org/packages/11/b6/abcb525026a4be042b486df43905d6893fb04f05aac21c32c638e939e447/pip-9.0.1.tar.gz
		yum -y install zlib*
		#python get-pip.py
		#rm -rf get-pip.py
	fi

	#after  that, install sqlite3 before run qqbot
	wget http://www.sqlite.org/2018/sqlite-autoconf-3220000.tar.gz




}
