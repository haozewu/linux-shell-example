#!/bin/bash
# 以上为指定运行脚本的程序，即/bin/bash

set -e # 指定运行方式，如果有错误，则退出

echo $(dirname $0) # $0代表第零个输入，即脚本指令，dirname对指令进行截取，输出脚本所在相对目录

echo $(cd $(dirname $0);pwd) # cd到脚本所在路径后，输出脚本所在绝对目录

script_dir=$(cd $(dirname $0);pwd) # 将脚本所在目录赋值给变量

echo $script_dir # 输出脚本所在绝对路径

res=2
echo '1'+'1='$res # 注意加号在文本拼接不会隐藏
