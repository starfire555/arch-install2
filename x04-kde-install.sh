### KDE Install ###

echo ">>> Installing KDE"
sudo pacman -S xorg sddm plasma kde-applications packagekit-qt5 papirus-icon-theme materia-kde materia-gtk-theme papirus-icon-theme
sudo systemctl set-default graphical
sudo systemctl enable sddm

echo '#!/bin/bash' > /home/x/.xinitrc
echo 'startplasma-x11' >> /home/x/.xinitrc
chmod +x /home/x/.xinitrc
echo "..........................................................."

echo ""
echo "###########################################"
echo "### KDE install completed successfully. ###"
echo "###########################################"
echo ""
