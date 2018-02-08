#!/bin/bash

#to install hpl-2.2

#platform:openmpi

mkdir hpl_install
cd hpl_install
wget http://www.netlib.org/benchmark/hpl/hpl-2.2.tar.gz
tar -zxvf hpl-2.2.tar.gz
wget --no-check-certificate https://www.tacc.utexas.edu/documents/1084364/1087496/GotoBLAS2-1.13.tar.gz
tar -zxvf GotoBLAS2-1.13.tar.gz
cd GotoBLAS2


