
yum install yum-utils
# 因为国内源问题，本功能不可用。
yum-builddep python3

# 所以国内安装要自己加一堆东西，要么换成国外源
yum install -y bzip2-devel # +后续无穷个依赖


./configure --prefix=/usr/local/python39
make
make install
