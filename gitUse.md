/* 创建一个 readme.md 文件 */
root@localhost:/home/baidu# vim readme.md

/* 输出 readme.md 文件内容 */
root@localhost:/home/baidu# cat readme.md 
Git关联GitHub
=============

/* 将文件添加到暂存区 */
root@localhost:/home/baidu# git add readme.md 

/* 提交本次修改 */
root@localhost:/home/baidu# git commit -m "add readme file"
[master 228d321] add readme file
 1 file changed, 2 insertions(+)
 create mode 100644 readme.md
 
 /* 推送到远程仓库 */
root@localhost:/home/baidu# git push origin master
Counting objects: 3, done.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 290 bytes | 0 bytes/s, done.
Total 3 (delta 0), reused 0 (delta 0)
To git@github.com:woider/baidu.git
   36c5c1c..228d321  master -> master

root@localhost:/home/baidu#
