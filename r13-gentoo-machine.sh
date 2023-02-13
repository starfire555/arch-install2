mkdir /etc/systemd/nspawn

# GENTOO         
cp gentoo.nspawn /etc/systemd/nspawn/
cd /var/lib/machines/
ln -s /mnt/gentoo/ gentoo
#machinectl enable gentoo

#ARCH-01
#cd /arch-bb-install
#cp arch-01.nspawn /etc/systemd/nspawn/
#cd /var/lib/machines/
#mkdir -p /mnt/machines/arch-01
#ln -s /mnt/machines/arch-01/ arch-01

#mkdir /export/arch-01
#echo '/mnt/machines/arch-01    /export/arch-01    none    bind    0    0' >> /etc/fstab
#systemctl daemon-reload
#mount /export/arch-01

#systemctl set-property systemd-nspawn@arch-01.service CPUQuota=400%
#https://wiki.archlinux.org/title/Systemd-nspawn#:~:text=systemd-nspawn%20is%20like%20the%20chroot%20command%2C%20but%20it,IPC%20subsystems%20and%20the%20host%20and%20domain%20name.
