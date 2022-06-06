# 解压
tar -zxvf xxx.tar.gz

# tar压缩 /aaa/bbb 为 xxx.tar.gz
tar -zcvf xxx.tar.gz /aaa/bbb

# zip压缩/aaa，不包含/aaa/bbb
zip -r xxx.zip /aaa -x /aaa/bbb

