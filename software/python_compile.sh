
yum install yum-utils
# 因为国内源问题，本功能不可用。
yum-builddep python3

# 所以国内安装要自己加一堆东西，要么换成国外源
yum install openssl-devel libffi-devel bzip2-devel -y

./configure --prefix=/usr/local/python39
make
make install
