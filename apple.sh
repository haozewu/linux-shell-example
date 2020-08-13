#!/bin/bash
set -e

cp article.md article.md.tmp
# 年份全换成换行
# sed -i '/^2020年/c\\n' article.md.tmp
sed -i '/^2020年/d' article.md.tmp
sed -i s/[[:space:]]//g article.md.tmp
# 输出每一个标题，把第一个前面加## ，后面删行
all_title=`sort article.md.tmp | uniq -d`
for title in $all_title
do
# 替换title加两个#
sed -i "1,/$title/{s/$title/## $title/}"  article.md.tmp
# 删除所有剩余的标题
sed -i "/^$title/d" article.md.tmp
done
# 删除1-4行
sed -i '1,4d' article.md.tmp
# 对文件进行单空行处理
sed -i '/^$/d; $!G' article.md.tmp
# 删除所有空行
# sed -i '/^$/d' article.md.tmp

# 知识点

# https://blog.csdn.net/holandstone/article/details/8488434