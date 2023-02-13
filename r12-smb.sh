cp smb.conf /etc/samba/
smbpasswd -a x
systemctl enable --now smb nmb
