#DEBIAN-01
cd /arch-bb-install
cp debian-01.nspawn /etc/systemd/nspawn/
cd /var/lib/machines/
mkdir -p /mnt/machines/debian-01
ln -s /mnt/machines/debian-01/ debian-01

#mkdir /export/debian-01
#echo '/mnt/machines/debian-01    /export/debian-01    none    bind    0    0' >> /etc/fstab
#systemctl daemon-reload
#mount /export/debian-01


#pacman -S debootstrap
#debootstrap --include=systemd-container stable /mnt/machines/debian-01 http://deb.debian.org/debian/
#systemctl set-property systemd-nspawn@debian-01.service CPUQuota=400%
#systemd-nspawn -D /mnt/machines/debian-01/ passwd
cp /etc/resolv.conf /mnt/machines/debian-01/etc/


#IN DEBIAN
#systemctl enable --now systemd-networkd systemd-resolved
#apt install neofetch xfce4 xrdp handbrake
#systemctl enable --now xrdp
#useradd -m x
#passwd x

#cat <<EOF > /etc/polkit-1/localauthority/50-local.d/45-allow-colord.pkla
#[Allow Colord all Users]
#Identity=unix-user:*
#Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-dev>
#ResultAny=no
#ResultInactive=no
#ResultActive=yes
#EOF


#https://wiki.archlinux.org/title/Systemd-nspawn#:~:text=systemd-nspawn%20is%20like%20the%20chroot%20command%2C%20but%20it,IPC%20subsys>
