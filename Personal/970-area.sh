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

echo

echo
echo "Overwriting /etc/nanorc settings"
echo

if [ -f /etc/nanorc-nemesis ]; then
  # Do nothing because backup already exists
  :
elif [ -f /etc/nanorc ]; then
  sudo mv -v /etc/nanorc /etc/nanorc-nemesis
  sudo cp -v $installed_dir/settings/nano/nanorc /etc/nanorc
fi

#echo
#echo "Enable fstrim timer for SSD"
#sudo systemctl enable fstrim.timer

# personal /etc/pacman.d/gnupg/gpg.conf
echo
tput setaf 2
echo "################################################################################"
echo "Copying gpg.conf to /etc/pacman.d/gnupg/gpg.conf"
echo "################################################################################"
tput sgr0
echo

if [ -f /etc/pacman.d/gnupg/gpg.conf-nemesis ]; then
  # Do nothing because backup already exists
  :
elif [ -f /etc/pacman.d/gnupg/gpg.conf ]; then
  sudo mv -v /etc/pacman.d/gnupg/gpg.conf /etc/pacman.d/gnupg/gpg.conf-nemesis
  sudo cp $installed_dir/settings/gnupg/gpg.conf /etc/pacman.d/gnupg/gpg.conf
fi


# we are on Area

if [ -f /usr/local/bin/get-nemesis-on-area ]; then

	echo
	tput setaf 2
	echo "########################################################################"
	echo "################### We are on Area"
	echo "########################################################################"
	tput sgr0
	echo

	echo
	echo "Installing edu packages"
	sudo pacman -S --noconfirm  edu-skel-git
  	sudo pacman -S --noconfirm  edu-xfce-git
  	sudo pacman -S --noconfirm  edu-system-git
  	sudo pacman -S --noconfirm --needed rxvt-unicode
	sudo pacman -S --noconfirm --needed rxvt-unicode-terminfo
	echo

	echo
	echo "Change gtk-3.0 config"
	echo
	FIND="Sardi-Arc"
	REPLACE="Sardi-Colora"
	sed -i "s/$FIND/$REPLACE/g" $HOME/.config/gtk-3.0/settings.ini
	sudo sed -i "s/$FIND/$REPLACE/g" /etc/skel/.config/gtk-3.0/settings.ini

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


	if [ -f /usr/share/xsessions/xfce.desktop ]; then
		echo
		tput setaf 2
		echo "########################################################################"
		echo "################### We are on Xfce4"
		echo "########################################################################"
		tput sgr0
		echo

		cp -arf /etc/skel/. ~

		echo
		echo "Changing the whiskermenu"
		echo
		[ -d ~/.config/xfce4/panel ] || mkdir -p ~/.config/xfce4/panel
		cp $installed_dir/settings/ariser/whiskermenu-7.rc ~/.config/xfce4/panel/whiskermenu-7.rc
		[ -d /etc/skel/.config/xfce4/panel ] || sudo mkdir -p /etc/skel/.config/xfce4/panel
		sudo cp $installed_dir/settings/ariser/whiskermenu-7.rc /etc/skel/.config/xfce4/panel/whiskermenu-7.rc

		echo
		echo "Changing the icons and theme"
		echo

		FIND="Arc-Dark"
		REPLACE="Arc-Dawn-Dark"
		sed -i "s/$FIND/$REPLACE/g" ~/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
		sudo sed -i "s/$FIND/$REPLACE/g" /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml

		FIND="Sardi-Arc"
		REPLACE="Sardi-Colora"
		sed -i "s/$FIND/$REPLACE/g" ~/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
		sudo sed -i "s/$FIND/$REPLACE/g" /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml

	fi

	# systemd

	echo "Journald.conf - volatile"

	FIND="#Storage=auto"
	REPLACE="Storage=auto"
	#REPLACE="Storage=volatile"
	sudo sed -i "s/$FIND/$REPLACE/g" /etc/systemd/journald.conf

	echo
	echo "ArchLinux Logout - beauty icons"
	echo

	[ -d $HOME"/.config/archlinux-logout/" ] || mkdir -p $HOME"/.config/archlinux-logout"
	cp  $installed_dir/settings/archlinux-logout/archlinux-logout-beauty.conf $HOME/.config/archlinux-logout/archlinux-logout.conf
	sudo cp  $installed_dir/settings/archlinux-logout/archlinux-logout-beauty.conf /etc/archlinux-logout.conf
	echo

	tput setaf 6
	echo "########################################################################"
	echo "################### Done"
	echo "########################################################################"
	tput sgr0
	echo

fi

echo
tput setaf 3
echo "########################################################################"
echo "FINAL SKEL"
echo "Copying all files and folders from /etc/skel to ~"
echo "First we make a backup of .config"
echo "Wait for it ...."
echo "########################################################################"
tput sgr0
echo

#cp -Rf ~/.config ~/.config-backup-$(date +%Y.%m.%d-%H.%M.%S)
#cp -arf /etc/skel/. ~

echo
tput setaf 6
echo "##############################################################"
echo "###################  $(basename $0) done"
echo "##############################################################"
tput sgr0
echo