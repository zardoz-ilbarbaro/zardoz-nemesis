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

#echo
#echo "Enable fstrim timer for SSD"
#sudo systemctl enable fstrim.timer


echo
tput setaf 2
echo "################################################################################"
echo "Copying gpg.conf to /etc/pacman.d/gnupg/gpg.conf"
echo "################################################################################"
tput sgr0
echo

# personal /etc/pacman.d/gnupg/gpg.conf
sudo cp $installed_dir/settings/gnupg/gpg.conf /etc/pacman.d/gnupg/gpg.conf

read response
if [[ "$response" == [yY] ]]; then

	
	echo
	echo "Setting environment variables"
	echo
	if [ -f /etc/environment ]; then
		echo "QT_QPA_PLATFORMTHEME=qt5ct" | sudo tee /etc/environment
		echo "EDITOR=nano" | sudo tee -a /etc/environment
		echo "BROWSER=firefox" | sudo tee -a /etc/environment
	fi

	if [ -f /boot/loader/loader.conf ]; then
		echo
		echo "Removing pacman hook for grub"
		echo "By default Ariser is systemd-boot"
		echo
		if [ -f /etc/pacman.d/hooks/grub-install.hook ]; then
			sudo rm /etc/pacman.d/hooks/grub-install.hook
		else
			echo "Already removed /etc/pacman.d/hooks/grub-install.hook"
		fi
		if [ -f /etc/pacman.d/hooks/grub-mkconfig.hook ]; then
			sudo rm /etc/pacman.d/hooks/grub-mkconfig.hook
		else
			echo "Already removed /etc/pacman.d/hooks/grub-mkconfig.hook"
		fi
	fi

	echo
	echo "copying cursor file"
	if [ -d /usr/share/icons/default/cursors ]; then
		sudo rm /usr/share/icons/default/cursors
	fi
	[ -d /usr/share/icons/default ] || sudo mkdir -p /usr/share/icons/default
	sudo cp -f $installed_dir/settings/cursor/* /usr/share/icons/default
	echo


	# systemd

	echo "Journald.conf - volatile"

	FIND="#Storage=auto"
	REPLACE="Storage=auto"
	#REPLACE="Storage=volatile"
	sudo sed -i "s/$FIND/$REPLACE/g" /etc/systemd/journald.conf

	tput setaf 6
	echo "########################################################################"
	echo "################### Done"
	echo "########################################################################"
	tput sgr0
	echo

fi




echo
tput setaf 6
echo "##############################################################"
echo "###################  $(basename $0) done"
echo "##############################################################"
tput sgr0
echo