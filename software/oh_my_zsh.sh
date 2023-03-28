
# ubuntu安装zsh
sudo apt -y install zsh
# centos
sudo yum -y install zsh

# 更换sh
chsh -s /bin/zsh
# 给其他用户更换
sudo chsh -s /bin/zsh username

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# 国内的VPS无法获取安装脚本，使用以下指令或者gitee库
wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh

# 自动补全插件
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
#高亮指令插件
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# 修改主题可设置 ZSH_THEME="ys"
# 更改本行内容： plugins=(git zsh-syntax-highlighting zsh-autosuggestions)
# 然后source
source ~/.zshrc
