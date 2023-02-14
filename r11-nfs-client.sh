##############
### CLIENT ###
##############

pacman -S nfs-utils

#mount gentoo-bb:/hdd1 /mnt/nfs/gentoo-bb/hdd1
#mount gentoo-bb:/hdd2 /mnt/nfs/gentoo-bb/hdd2
#mount gentoo-pro:/hdd1 /mnt/nfs/gentoo-pro/hdd1

mkdir -p /mnt/nfs/gentoo-bb/{hdd1,hdd2,hdd3}
mkdir -p /mnt/nfs/gentoo-pro/hdd1
chown -R x: /mnt/nfs

echo 'gentoo-bb:/hdd1    /mnt/nfs/gentoo-bb/hdd1    nfs    rw,_netdev,noauto,user    0    0' >> /etc/fstab
echo 'gentoo-bb:/hdd2    /mnt/nfs/gentoo-bb/hdd2    nfs    rw,_netdev,noauto,user    0    0' >> /etc/fstab
echo 'gentoo-bb:/hdd3    /mnt/nfs/gentoo-bb/hdd3    nfs    rw,_netdev,noauto,user    0    0' >> /etc/fstab
echo 'gentoo-pro:/hdd1   /mnt/nfs/gentoo-pro/hdd1   nfs    rw,_netdev,noauto,user    0    0' >> /etc/fstab

systemctl daemon-reload
mount /mnt/nfs/gentoo-bb/hdd1
mount /mnt/nfs/gentoo-bb/hdd2
mount /mnt/nfs/gentoo-bb/hdd3
mount /mnt/nfs/gentoo-pro/hdd1
