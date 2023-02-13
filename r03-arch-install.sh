clear

echo ">>> Setting ParallelDownloads = 20 in /etc/pacman.conf"
sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 20/g' /etc/pacman.conf
echo "..........................................................."

echo ">>> Setting Timezone to Europe/London into /etc/localtime"
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime && hwclock --systohc
echo "..........................................................."

echo ">>> Setting locale to en_GB.UTF-8 UTF-8"
echo "en_GB.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_GB.UTF-8" > /etc/locale.conf
echo "..........................................................."

#nano -w /etc/vconsole.conf #???

echo ">>> Setting hostname to arch-bb"
echo "arch-bb" > /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts && echo "::1 localhost" >> /etc/hosts && echo "127.0.1.1 arch-bb.localdomain arch-bb" >> /etc/hosts
echo "..........................................................."

echo ">>> Setting root passwd to password"
echo root:password | chpasswd
echo "..........................................................."

echo ">>> Installing main software"
pacman -S --noconfirm base-devel nano btrfs-progs openssh grub efibootmgr dialog mtools dosfstools git reflector xdg-utils xdg-user-dirs alsa-utils pulseaudio inetutils bash-completion rsync
#pacman -S networkmanager
echo "..........................................................."
#read -p "Press enter to continue"

echo ">>> Setting march=sandybridge and MAKEFLAGS=-j9 in /etc/makepkg.config"
sed -i 's/-march=x86-64/-march=sandybridge/g' /etc/makepkg.conf
sed -i 's/ -mtune=generic//g' /etc/makepkg.conf
sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j9"/g' /etc/makepkg.conf
echo "..........................................................."

echo ">>> Installing kernel"
pacman -S --noconfirm mkinitcpio linux-firmware intel-ucode
sed -i 's/MODULES=()/MODULES=(btrfs)/g' /etc/mkinitcpio.conf
# FOR INSTALL TO USB sed -i 's/HOOKS=(base udev autodetect modconf kms keyboard keymap consolefont block filesystems fsck)/HOOKS=(base udev keyboard block autodetect modconf kms keymap consolefont filesystems fsck)/g' /etc/mkinitcpio.conf
pacman -U --noconfirm linux-zen-custom-6.1.8.zen1-1-x86_64.pkg.tar.zst linux-zen-custom-headers-6.1.8.zen1-1-x86_64.pkg.tar.zst
echo "..........................................................."
#read -p "Press enter to continue"

#echo ">>> mkinitcpio"
#mkinitcpio -p linux-zen-custom #with btrfs included
#echo "..........................................................."
#read -p "Press enter to continue"

echo ">>> Installing GRUB"
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch
# FOR INSTALL TO USB grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch --removable --recheck
grub-mkconfig -o /boot/grub/grub.cfg
#efibootmgr -o 0003
#efibootmgr -B -b 0000
echo "..........................................................."

echo ">>> Configuring systemd-networkd"
cat <<EOF > /etc/systemd/network/20-wired.network
[Match]
Name=eno1
#altname enp0s25

[Network]
DHCP=yes

[DHCPv4]
RouteMetric=10
EOF
echo "..........................................................."

echo ">>> Enabling systemd-networkd, systemd-resolved, sshd in systemd"
systemctl enable systemd-networkd systemd-resolved sshd
echo "..........................................................."

echo ">>> Creating user: x. Setting x passwd to password"
useradd -mG wheel x
echo x:password | chpasswd
echo "x ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers.d/x
echo "..........................................................."
#read -p "Press enter to continue"

echo ">>> Installing yay and paru-bin"
echo "password" | sudo -S -u x mkdir /home/x/sources
cd /home/x/sources
sudo -u x git clone https://aur.archlinux.org/yay
cd /home/x/sources/yay

sudo -u x makepkg -si --noconfirm
sudo -u x yay -S --noconfirm paru-bin
echo "..........................................................."

echo ""
echo "############################################"
echo "### Base install completed successfully. ###"
echo "############################################"
echo ""
echo "exit, umount -R /mnt/arch, reboot"
echo "After reboot, proceed as a normal user."
