#!/bin/bash

# 一般来说，centos包含两个防火墙，selinux和firewalld

service iptables stop # 停止防火墙
chkconfig iptables off # 停止防火墙自启动

# 配置防火墙


# selinux
setstatus -v # 查看状态
getenforce # 查看状态

setenforce 0 # 暂时关闭
setenforce 1 # 打开
vi /etc/selinux/config # 永久关闭selinux

# 配置selinux

