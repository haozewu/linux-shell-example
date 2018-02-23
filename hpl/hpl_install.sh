#!/bin/bash

#plan:
#	if have mpienv,install GotoBLAS2
#	if not, run mpi_install


#to install hpl-2.2

#platform:centos6,openmpi，

mpi_install(){
	wget http://www.mpich.org/static/downloads/3.2.1/mpich-3.2.1.tar.gz
	tar -zxvf mpich-3.2.1.tar.gz
	echo '1' | sudo -S yum -y install gcc-c++
	cd /home/wu/software/mpich-3.2.1/
	./configure --disable-fortran
	make
	echo '1' | sudo -S make install
}
hpl_install(){
	hplarch=test

	mkdir hpl_install
	cd hpl_install
	wget http://www.netlib.org/benchmark/hpl/hpl-2.2.tar.gz
	tar -zxvf hpl-2.2.tar.gz
	wget --no-check-certificate https://www.tacc.utexas.edu/documents/1084364/1087496/GotoBLAS2-1.13.tar.gz
	tar -zxvf GotoBLAS2-1.13.tar.gz
	cd GotoBLAS2


	#
	#maybe just apt-get or yum
	#the code bellow need to test
	#
	#
	sed -i "s#TARGET=??????#TARGET=PENRYN#g" ./Makefile.rule
	sed -i "s#CC=????????#CC=gcc#g" ./Makefile.rule
	sed -i "s#FC=??????#FC=gfortran#g" ./Makefile.rule
	sed -i "s#BINARY=64#BINARY=linux#g" ./Makefile.rule

	#this step may need to change the name of some lib

	make
	make install
	cd ../hpl-2.2/
	cp setup/Make.Linux_ATHLON_FBLAS  ./Make.test
	sed -i "s#ARCH=Linux_ATHLON_FBLAS#ARCH=$(hplarch)#g" ./Makefile.rule
	sed -i "s#TOPdir=??????#TOPdir=PENRYN#g" ./Makefile.rule
	sed -i "s#MPdir=??????#MPdir=PENRYN#g" ./Makefile.rule
	sed -i "s#MPinc=?????#MPinc=PENRYN#g" ./Makefile.rule
	sed -i "s#MPlib=#MPlib=#g" ./Makefile.rule
	sed -i "s#LAdir=??????#LAdir=PENRYN#g" ./Makefile.rule
	sed -i "s#LAlib=??????#LAlib=PENRYN#g" ./Makefile.rule
	sed -i "s#CC=??????#CC=PENRYN#g" ./Makefile.rule
	make arch=$(hplarch)
}


