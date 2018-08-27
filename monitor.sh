# 查看负载情况
w

# 查看本机开放端口
netstat -lntp


netstat 

# 压力测试  共计1000000并发，每秒增加40次
ab -n 1000000 -c 40 http://example.com