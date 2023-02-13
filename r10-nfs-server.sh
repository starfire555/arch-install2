##############
### SERVER ###
##############

pacman -S --noconfirm nfs-utils
mkdir /export
mkdir /export/hdd1
mkdir /export/hdd2
mkdir /export/hdd3

#mount --bind /mnt/sdc /export/hdd1
#mount --bind /mnt/sdd /export/hdd2
#mount --bind /mnt/sdb /export/hdd3
echo '/mnt/sdc    /export/hdd1    none    bind    0    0'  >> /etc/fstab
echo '/mnt/sdd    /export/hdd2    none    bind    0    0'  >> /etc/fstab
echo '/mnt/sdb    /export/hdd3    none    bind    0    0'  >> /etc/fstab

systemctl daemon-reload
mount /export/hdd1
mount /export/hdd2
mount /export/hdd3

echo '/export         192.168.1.0/24(insecure,rw,sync,no_subtree_check,crossmnt,fsid=0)' >> /etc/exports
echo '/export/hdd1    192.168.1.0/24(insecure,rw,sync,no_subtree_check)' >> /etc/exports
echo '/export/hdd2    192.168.1.0/24(insecure,rw,sync,no_subtree_check)' >> /etc/exports
echo '/export/hdd3    192.168.1.0/24(insecure,rw,sync,no_subtree_check)' >> /etc/exports

echo 'RPCNFSDARGS="8 -V 3 -V 4"' >> /etc/conf.d/nfs

systemctl enable --now rpcbind nfs-server

