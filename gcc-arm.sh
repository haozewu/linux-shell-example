#!/bin/bash

#install gcc-arm&OpenOCD


mkdir temp
cd temp
wget https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q3-update/+download/gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2

#OpenOCD Fail!
wget https://jaist.dl.sourceforge.net/project/openocd/openocd/0.10.0/openocd-0.10.0.tar.bz2
#install before installing OpenOCD
wget https://codeload.github.com/libusb/libusb/tar.gz/1.0.9
#autoconf:libusb require
wget http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz

tar -jxvf gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2
tar -jxvf openocd-0.10.0.tar.bz2
unzip libusb-master.zip

#libusb:OpenOCD require
cd libusb-master
./configure --disable-udev
make
sudo make install
cd..


#install OpenOCD
cd openocd-0.10.0
try{
	sudo yum install libusb++-dev
}
./configure



mv gcc-arm-none-eabi-5_4-2016q3 ARMLibrary
#install to ~/ARMLibrary
mv ARMLibrary/ ~/
cd ..
rm -r temp

#add in /etc/profile
#!!!!!!!!!!
try{
	echo -e "export PATH=$PATH:/home/haoze/ARMLibrary/bin" >> /etc/profile
	source /etc/profile
}catch{
	echo "Error in write to /etc/profile."
}
#if no /lib/ld-linux.so.2
try{
	sudo yum install ld-linux.so.2
}catch{
	echo "Error in installing glibc."
}



