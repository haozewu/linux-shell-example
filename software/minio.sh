
# 先准备好新版minio和mc安装包
chmod +x minio
chmod +x mc
mv mc /usr/local/bin/mc
mv minio /usr/local/bin/minio

# 在 bashrc 中添加admin登录方法
export MINIO_ROOT_USER=minio
export MINIO_ROOT_PASSWORD=minio13

nohup minio server /data --address ":9000" > /var/log/minio.log 2>&1 &

# 设置nginx转发时，只需要即可
# proxy_pass http://localhost:<port>/<bucket>/<folder>;
