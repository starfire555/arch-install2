# All scripts must start in /arch-install

### Format and Mount ###
_boot=/dev/sda5
_root=/dev/nvme0n1p1
_efi=/dev/sda1

clear
umount -Rq /mnt/arch/boot/efi
umount -Rq /mnt/arch/boot
umount -Rq /mnt/arch
umount -q $_efi
umount -q $_boot
umount -q $_root
rm -Rf /mnt/arch
mkdir -p /mnt/arch

echo ""
echo "............................................."
echo ""
echo "Current contents of /mnt/arch:"
echo ""
ls -lat /mnt/arch
echo ""
echo "............................................."

echo "Devices to be modified:"
echo ""
echo $_root ": root (Format to btrfs with @ and @home subvolumes. Mount to /mnt/arch.)"
echo $_boot ": boot (Format to ext4. Mount to /mnt/arch/boot.)"
echo $_efi ": efi (Mount to /mnt/arch/efi.)"
echo ""
read -p "Press enter to proceed."


mkfs.ext4 -F $_boot
mkfs.btrfs -f $_root
mount $_root /mnt/arch
btrfs su cr /mnt/arch/@
btrfs su cr /mnt/arch/@home
#btrfs su cr /mnt/arch/@snapshots
#btrfs su cr /mnt/arch/@var_log 
umount /mnt/arch

mount -o noatime,compress=lzo,space_cache=v2,subvol=@ $_root /mnt/arch 
mkdir -p /mnt/arch/{boot,home}
#mkdir -p /mnt/arch/{.snapshots,var_log}
mount -o noatime,compress=lzo,space_cache=v2,subvol=@home $_root /mnt/arch/home 
#mount -o noatime,compress=lzo,space_cache=v2,subvol=@snapshots $_root /mnt/arch/.snapshots
#mount -o noatime,compress=lzo,space_cache=v2,subvol=@var_log $_root /mnt/arch/var_log
mount $_boot /mnt/arch/boot
mkdir /mnt/arch/boot/efi
mount $_efi /mnt/arch/boot/efi
rm -Rf /mnt/arch/boot/efi/EFI/arch

cp -R ../arch-bb-install /mnt/arch/

echo ""
echo "............................................."
echo ""
echo "Current contents of /mnt/arch:"
echo ""
ls -la /mnt/arch
echo ""
echo "............................................."

echo ""
echo "##################################################"
echo "### Drives formatted and mounted successfully. ###"
echo "##################################################"
echo ""
