# linux learning to avoid forget

## set ssh config

### make ssh key

> ssh-keygen

特别说明，其中有一个问题是，要不要对私钥设置口令（passphrase），如果担心私钥的安全，这里可以设置一个（设置私钥口令的目的是防止私钥被盗用），但是设置之后，利用私钥连接也需要输入密码。

运行结束以后，在 $HOME/.ssh/ 目录下，会新生成两个文件：id_rsa.pub 和 id_rsa。前者是你的公钥，后者是你的私钥。再一次强调用户自己的目录（~/.ssh）必须不能有其他人可写的权限， .ssh 目录的权限必须是 700, chmod 700 ~/.ssh 必须。否则ssh服务器会拒绝登录。
产生的公钥/私钥文件在用户home目录的.ssh目录下，其中id_dsa.pub是公钥，把产生的公钥上传到需要登陆的服务器的对应用户目录的home目录的.ssh目录下，再一次强调用户自己的目录(home目录)必须不能有其他人可写的权限，.ssh目录的权限必须是700，即除了用户自己，其他人没有任何读写察看该目录的权限，否则ssh服务器会拒绝登陆。

ssh服务器端默认的公钥文件是用户home目录下的.ssh目录下的authorized_keys文件，因此需要把产生的公钥以这个文件名放到服务器的~user/.ssh/目录下，这个文件中可以存放多个客户端的公钥文件，就好比一个大门上可以上很多锁，可以有不同的钥匙来尝试开锁，只要有一个锁被打开了，门就可以打开了。放到服务器上应该是这样子的：公钥必须是600权限，否则ssh服务器会拒绝用户登陆。

sshd 服务器端默认的公钥文件是用户home目录下的.ssh目录下的 authorized_keys 文件，因此需要把产生的公钥以这个文件名放到服务器的 $HOME/.ssh/ 目录下，这个文件中可以存放多个客户端的公钥文件，就好比一个大门上可以上很多锁，可以有不同的钥匙来尝试开锁，只要有一个锁被打开了，门就可以打开了。~/.ssh/authorized_keys 必须是600权限，否则ssh服务器会拒绝用户登陆。chmod 600 ~/.ssh/authorized_keys

### 把生成的密钥文件上传到远程主机

这时再输入下面的命令，将生成的公钥传送到远程主机host上面对应用户home目录下的 .ssh 目录下：

2、将公钥上传到欲远程连接的主机上面

> ssh-copy-id user@host

好了，经过以上两步之后，从此你再登录，就不需要输入密码了。此命令执行后，远程主机直接将用户的公钥保存在 ~/.ssh/authorized_keys 文件中。

如果还是不行，就打开远程主机的 /etc/ssh/sshd_config 这个文件，检查下面几行前面"#"注释是否取掉。

然后重新启动远程主机的sshd服务：
> /etc/init.d/ssh restart

## set proxy
把代理服务器地址写入shell配置文件.bashrc或者.zshrc

直接在.bashrc或者.zshrc添加下面内容
```
export http_proxy="http://localhost:port"
export https_proxy="http://localhost:port"
```

以使用shadowsocks代理为例，ss的代理端口为1080,那么应该设置为
```
export http_proxy="socks5://127.0.0.1:1080"
export https_proxy="socks5://127.0.0.1:1080"
```
或者直接设置ALL_PROXY
> export ALL_PROXY=socks5://127.0.0.1:1080

## git

### basic

https://git-scm.com/docs/user-manual.html