#!/bin/bash
set -uo pipefail  # Do not use set -e, we want to continue on error
##################################################################################################################
# Author    : Erik Dubois
# Website   : https://www.erikdubois.be
# Youtube   : https://youtube.com/erikdubois
# Github    : https://github.com/erikdubois
# Github    : https://github.com/kirodubes
# Github    : https://github.com/buildra
# SF        : https://sourceforge.net/projects/kiro/files/
##################################################################################################################
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

#end colors
#tput sgr0
##################################################################################################################################

# Trap all ERR conditions and call the handler
trap 'on_error $LINENO "$BASH_COMMAND"' ERR

on_error() {
    local lineno="$1"
    local cmd="$2"

    # Set colors
    RED=$(tput setaf 1)
    YELLOW=$(tput setaf 3)
    RESET=$(tput sgr0)

    echo
    echo "${RED}⚠️ ERROR DETECTED${RESET}"
    echo "${YELLOW}✳️  Line: $lineno"
    echo "📌  Command: '$cmd'"
    echo "⏳  Waiting 10 seconds before continuing...${RESET}"
    echo

    sleep 10
}


#networkmanager issue
#nmcli connection modify Wired\ connection\ 1 ipv6.method "disabled"

# what is the present working directory
installed_dir=$(dirname $(readlink -f $(basename `pwd`)))

##################################################################################################################################

# set DEBUG to true to be able to analyze the scripts file per file
#
# works on Bash not Fish
# sudo chsh -s /usr/bin/bash erik
# logout and login to change from zsh or fish to bash

export DEBUG=false

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

# order is important - dependencies
echo
tput setaf 2
echo "################################################################################"
echo "Installing Chaotic keyring and Chaotic mirrorlist"
echo "################################################################################"
tput sgr0
echo

for pkg in packages/*.pkg.tar.zst; do
    [ -f "$pkg" ] && sudo pacman -U --noconfirm "$pkg"
done

echo
tput setaf 2
echo "################################################################################"
echo "Updating the system - sudo pacman -Syyu - before 700-intervention"
echo "################################################################################"
tput sgr0
echo

sudo pacman -Syyu --noconfirm

echo
tput setaf 2
echo "################################################################################"
echo "Installing much needed software"
echo "################################################################################"
tput sgr0
echo

#first get tools for whatever distro
sudo pacman -S sublime-text-4 --noconfirm --needed
sudo pacman -S ripgrep --noconfirm --needed
sudo pacman -S meld --noconfirm --needed

# if on Arco... and systemd-boot is chosen, then proceed with
if [[ -f /etc/dev-rel ]]; then

    if [[ "$(sudo bootctl is-installed 2>/dev/null)" == "yes" ]]; then
        echo
        tput setaf 3
        echo "########################################################################"
        echo "################### By default we choose systemd-boot"
        echo "################### This is to be able to change the kernel"
        echo "########################################################################"
        tput sgr0
        echo

        sudo pacman -S --noconfirm --needed pacman-hook-kernel-install
    fi
fi

echo
tput setaf 3
echo "########################################################################"
echo "################### Start of the scripts - choices what to launch or not"
echo "########################################################################"
tput sgr0
echo


sh 100-install-nemesis-software*
sh 200-install-cups*
sh install-samba*

echo
tput setaf 3
echo "########################################################################"
echo "################### Going to the Personal folder"
echo "########################################################################"
tput sgr0
echo

installed_dir=$(dirname $(readlink -f $(basename `pwd`)))
cd $installed_dir/Personal

sh 900-*

sh 970-area*


tput setaf 3
echo "########################################################################"
echo "End current choices"
echo "########################################################################"
tput sgr0
