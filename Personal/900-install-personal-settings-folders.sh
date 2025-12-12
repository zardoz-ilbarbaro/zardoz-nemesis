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

echo "########################################################################"
echo "################### Personal directories to create"
echo "########################################################################"
tput sgr0

[ -d /etc/skel/.config ] || sudo mkdir -p /etc/skel/.config

[ -d $HOME"/.bin" ] || mkdir -p $HOME"/.bin"
[ -d $HOME"/.fonts" ] || mkdir -p $HOME"/.fonts"
[ -d $HOME"/.icons" ] || mkdir -p $HOME"/.icons"
[ -d $HOME"/.themes" ] || mkdir -p $HOME"/.themes"
[ -d $HOME"/.local/share/icons" ] || mkdir -p $HOME"/.local/share/icons"
[ -d $HOME"/.local/share/themes" ] || mkdir -p $HOME"/.local/share/themes"
[ -d $HOME"/.local/share/applications" ] || mkdir -p $HOME"/.local/share/applications"
[ -d $HOME"/.config" ] || mkdir -p $HOME"/.config"
[ -d $HOME"/.config/xfce4" ] || mkdir -p $HOME"/.config/xfce4"
[ -d $HOME"/.config/autostart" ] || mkdir -p $HOME"/.config/autostart"
[ -d $HOME"/.config/xfce4/xfconf" ] || mkdir -p $HOME"/.config/xfce4/xfconf"
[ -d $HOME"/.config/gtk-3.0" ] || mkdir -p $HOME"/.config/gtk-3.0"
[ -d $HOME"/.config/gtk-4.0" ] || mkdir -p $HOME"/.config/gtk-4.0"
[ -d $HOME"/.config/neofetch" ] || mkdir -p $HOME"/.config/neofetch"



echo
tput setaf 2
echo "########################################################################"
echo "################### Personal settings to install - any OS"
echo "########################################################################"
tput sgr0
echo

echo
echo "Sublime text settings"
echo
[ -d $HOME"/.config/sublime-text/Packages/User" ] || mkdir -p $HOME"/.config/sublime-text/Packages/User"
cp  $installed_dir/settings/sublimetext/Preferences.sublime-settings $HOME/.config/sublime-text/Packages/User/Preferences.sublime-settings
echo

echo "Tozsh we go"
echo
sudo chsh $USER -s /bin/zsh

echo
tput setaf 6
echo "##############################################################"
echo "###################  $(basename $0) done"
echo "##############################################################"
tput sgr0
echo
