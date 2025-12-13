#!/bin/bash
#set -e
##################################################################################################################################
# Author    : Erik Dubois
# Website   : https://www.erikdubois.be
# Youtube   : https://youtube.com/erikdubois
##################################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################################
#tput setaf 0 = black
#tput setaf 1 = red
#tput setaf 2 = green
#tput setaf 3 = yellow
#tput setaf 4 = dark blue
#tput setaf 5 = purple
#tput setaf 6 = cyan
#tput setaf 7 = gray
#tput setaf 8 = light blue
##################################################################################################################################

installed_dir=$(dirname $(readlink -f $(basename `pwd`)))

##################################################################################################################################

if [ "$DEBUG" = true ]; then
    echo
    echo "------------------------------------------------------------"
    echo "Running $(basename $0)"
    echo "------------------------------------------------------------"
    echo
    read -n 1 -s -r -p "Debug mode is on. Press any key to continue..."
    echo
fi

##################################################################################################################################

sudo pacman -Sy

echo
tput setaf 2
echo "########################################################################"
echo "################### Installing software from nemesis_repo"
echo "########################################################################"
tput sgr0
echo

# reinstall because of release difference between ArcoLinux and Chaotic-Aur

if [ -f /usr/share/xsessions/xfce.desktop ]; then
  sudo pacman -S --noconfirm menulibre
  sudo pacman -S --noconfirm mugshot
fi

echo "Adding font to /etc/vconsole.conf"
if ! grep -q "FONT=" /etc/vconsole.conf; then
echo '
FONT=lat4-19' | sudo tee --append /etc/vconsole.conf
fi

sudo pacman -S --noconfirm --needed mkinitcpio-firmware
sudo pacman -S --noconfirm --needed arc-gtk-theme
sudo pacman -S --noconfirm --needed archlinux-logout-git
sudo pacman -S --noconfirm --needed arcolinux-arc-dawn-git
sudo pacman -S --noconfirm --needed edu-sddm-simplicity-git

sudo pacman -S --noconfirm --needed pamac-aur

sudo pacman -S --noconfirm  edu-skel-git
sudo pacman -S --noconfirm  edu-xfce-git
sudo pacman -S --noconfirm  edu-system-git
sudo pacman -S --noconfirm --needed rxvt-unicode
sudo pacman -S --noconfirm --needed rxvt-unicode-terminfo

# All the software below will be installed on all desktops
sudo pacman -S --noconfirm --needed xorg-xkill
sudo pacman -S --noconfirm --needed numlockx
sudo pacman -S --noconfirm --needed pavucontrol
sudo pacman -S --noconfirm --needed playerctl
sudo pacman -S --noconfirm --needed arandr
sudo pacman -S --noconfirm --needed catfish
sudo pacman -S --noconfirm --needed evince
sudo pacman -S --noconfirm --needed galculator
sudo pacman -S --noconfirm --needed adobe-source-sans-fonts
sudo pacman -S --noconfirm --needed avahi
sudo pacman -S --noconfirm --needed archlinux-tools
sudo pacman -S --noconfirm --needed btop
sudo pacman -S --noconfirm --needed curl
sudo pacman -S --noconfirm --needed dconf-editor
sudo pacman -S --noconfirm --needed downgrade
if [ ! -f /usr/bin/duf ]; then
  sudo pacman -S --noconfirm --needed duf
fi
sudo pacman -S --noconfirm --needed expac
sudo pacman -S --noconfirm --needed fakeroot
sudo pacman -S --noconfirm --needed file-roller
sudo pacman -S --noconfirm --needed gnome-disk-utility
sudo pacman -S --noconfirm --needed gparted
sudo pacman -S --noconfirm --needed inetutils
sudo pacman -S --noconfirm --needed inkscape
sudo pacman -S --noconfirm --needed logrotate
sudo pacman -S --noconfirm --needed lsb-release
sudo pacman -S --noconfirm --needed lshw
sudo pacman -S --noconfirm --needed man-db
sudo pacman -S --noconfirm --needed man-pages
sudo pacman -S --noconfirm --needed plocate
sudo pacman -S --noconfirm --needed ntp
sudo pacman -S --noconfirm --needed nss-mdns
sudo pacman -S --noconfirm --needed oh-my-zsh-git
sudo pacman -S --noconfirm --needed polkit-gnome
sudo pacman -S --noconfirm --needed qbittorrent
sudo pacman -S --noconfirm --needed rate-mirrors
sudo pacman -S --noconfirm --needed rsync
sudo pacman -S --noconfirm --needed scrot
sudo pacman -S --noconfirm --needed smartmontools
sudo pacman -S --noconfirm --needed squashfs-tools
sudo pacman -S --noconfirm --needed thunar
sudo pacman -S --noconfirm --needed thunar-archive-plugin
sudo pacman -S --noconfirm --needed thunar-volman
sudo pacman -S --noconfirm --needed ttf-dejavu
sudo pacman -S --noconfirm --needed ttf-droid
sudo pacman -S --noconfirm --needed ttf-hack
sudo pacman -S --noconfirm --needed ttf-ms-fonts
sudo pacman -S --noconfirm --needed ttf-roboto
sudo pacman -S --noconfirm --needed ttf-roboto-mono
sudo pacman -S --noconfirm --needed ttf-ubuntu-font-family
sudo pacman -S --noconfirm --needed mpv
sudo pacman -S --noconfirm --needed wget
sudo pacman -S --noconfirm --needed xdg-user-dirs
sudo pacman -S --noconfirm --needed neofetch-git
sudo pacman -S --noconfirm --needed zsh-completions
sudo pacman -S --noconfirm --needed zsh-syntax-highlighting
sudo systemctl enable avahi-daemon.service
sudo systemctl enable ntpd.service

sudo pacman -S --noconfirm --needed gzip
sudo pacman -S --noconfirm --needed p7zip
sudo pacman -S --noconfirm --needed unace
sudo pacman -S --noconfirm --needed unrar
sudo pacman -S --noconfirm --needed unzip

if [ ! -f /usr/share/xsessions/plasmax11.desktop ]; then
  sudo pacman -S --noconfirm --needed qt5ct
fi

sudo pacman -S --noconfirm --needed telegram-desktop


echo
tput setaf 6
echo "##############################################################"
echo "###################  $(basename $0) done"
echo "##############################################################"
tput sgr0
echo