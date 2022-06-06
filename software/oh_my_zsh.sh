apt  -y install zsh
# centos
yum -y install zsh
chsh -s /bin/zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# 修改主题可设置ZSH_THEME="ys"
# 国内的VPS无法获取安装脚本，用以下指令：
sudo apt-get install zsh
wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh

# 自动补全
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
# 更改本行内容： plugins=(git zsh-autosuggestions)

# 然后重启
