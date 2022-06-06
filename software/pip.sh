# 一般推荐使用venv
python3 -m pip install --user virtualenv

# 查看pip可用更新
pip list --outdated --format=columns

# 使用pip-review对pip更新软件包
pip3 install pip-review
pip-review --local --interactive
# 中途可能会出错，找不到处理依赖所需工具
sudo apt-get install -y pkg-config libcairo2-dev libgirepository1.0-dev build-essential libpython3-dev libdbus-1-dev
# python3.9-dev
# 用于分析当前项目所需依赖
pip3 install pipreqs
# windows
pipreqs . --encoding=utf8
# linux
pipreqs .


# pip只下载依赖，不安装
pip3 download -d <保存路径> -r requirements.txt

# 离线安装文件夹
pip3 install --no-index --find-links=/lib/pkgs -r requirements.txt
# 在线安装
pip3 install -r requirements.txt

pip install --upgrade <pkg_name>
pip3 list
