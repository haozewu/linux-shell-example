# 备份yum源
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak

# 更换源，参考https://mirrors.tuna.tsinghua.edu.cn/help/centos/
# 但上述指令只能更换标准版源

# 更换为阿里源
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

yum clean all
yum makecache

