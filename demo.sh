#/bin/bash

#wget https://pypi.python.org/packages/11/b6/abcb525026a4be042b486df43905d6893fb04f05aac21c32c638e939e447/pip-9.0.1.tar.gz
#tar -xf pip-9.0.1.tar.gz


wget http://www.zlib.net/zlib-1.2.11.tar.gz
tar -zxvf zlib-1.2.11.tar.gz
cd zlib-1.2.11
./configure
make
make install
cd ..

wget https://bootstrap.pypa.io/ez_setup.py -O - | sudo python


cd pip-9.0.1
python setup.py install

pip -v

wget http://www.sqlite.org/2018/sqlite-autoconf-3220000.tar.gz

tar -zxvf sqlite-autoconf-3220000.tar.gz
cd sqlite-autoconf-3220000
./configure --prefix=/usr/local
make
make install


皆さん、こんにちは、私は星空です、よろしくお願いします