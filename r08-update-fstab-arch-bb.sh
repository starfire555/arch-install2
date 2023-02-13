cat << EOF >> /etc/fstab

#/dev/sdb1
UUID=aa87395d-00c4-4077-846f-e4538c9bf6da       /mnt/sdb                btrfs           rw,relatime,user        0 0

#/dev/sdc1
UUID=d130d8a9-a47b-4ab1-b879-7e8eaecba799       /mnt/sdc                btrfs           rw,relatime,user        0 0

#/dev/sdd1
UUID=d2d4d369-9b13-4757-9abe-edb6163d454f       /mnt/sdd                btrfs           rw,relatime,user        0 0

# /dev/nvme0n1p3
UUID=bf1ae8d1-6a88-4968-8297-d0136b96cc39       /mnt/gentoo             btrfs           rw,noatime,compress=lzo,ssd,space_cache=v2,subvol=/@    0 0

# /dev/nvme0n1p3
UUID=bf1ae8d1-6a88-4968-8297-d0136b96cc39       /mnt/gentoo/home        btrfs           rw,noatime,compress=lzo,ssd,space_cache=v2,subvol=/@home        0 0

EOF

mkdir /mnt/{sdb,sdc,sdd,gentoo}
systemctl daemon-reload
mount /mnt/sdb
mount /mnt/sdc
mount /mnt/sdd
mount /mnt/gentoo
