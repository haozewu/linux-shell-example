# 分区表的概念：磁盘类型，例如ext，gpt，nfts

df -hl # 查看磁盘使用情况

lsblk # 查看块设备及挂载情况

fdisk -l /dev/sdx # 查看/dev/sdx的使用情况

fdisk /dev/sdx # 对小于2T的块设备 /dev/sdx进行分区
# 后续操作
n #创建新区
# 填入分区号
# 使用默认大小
# 确认即可创建

# 格式化整个块设备（gpt格式，支持大于2T）
parted -s /dev/sdx mklabel gpt

parted # 指令可以打开命令行
mkpart # 在命令行里使用mkpart可以创建分区

# 创建分区后需要格式化，即使是gpt格式，类型也是填写ext4
mkfs -t ext4 /dev/sdx1

mount /dev/sdx1 /dir # 挂载分区
mount -t ntfs-3g /dev/sdx1 /dir # 挂载ntfs格式（通常是windows）块设备
