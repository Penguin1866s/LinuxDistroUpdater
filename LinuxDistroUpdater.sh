#!/bin/bash
###Optimization suggestion: Change the $OS varibale, by a command that checks the package
### manager, as if you use apt or zypper, or xbps, or pacman ...

#The next two lines, are varibales for put text in bold.
bold=$(tput bold)
reset=$(tput sgr0)

#Options:
#opt-01: autoconfirmation
if [ "$1" == "-y" ]; then
    AUTO_CONFIRM="y"
else
    AUTO_CONFIRM="n"
fi

if [ "$(whoami)" == "root" ]; then
    echo "This script is execute by the user ${bold}$(whoami)${reset}"
else
    echo "This script is execute by the user ${bold}$(whoami)${reset}"
    echo 'you must run this script whith root privileges'
    exit
fi


SO="$(lsb_release -si)"
echo "Your Linux distro is ${bold}$SO${reset}"

#Updating for Ubuntu or LinuxMint_(apt).
if [ "$SO" == "Ubuntu" ] || [ "$SO" == "linuxmint" ]; then
    echo "Starting update Ubuntu or linuxmint.."
    apt update
    apt full-upgrade -y
    echo "End updating."

    echo "You want to auto-remove the outdated packages?(y/n)"
    if [ $AUTO_CONFIRM == "n" ]; then
        read CONFIRMATION
    elif [ $AUTO_CONFIRM == "y" ]; then
        CONFIRMATION="y"
    fi

    if [[ $CONFIRMATION == "y" || $COFIRMATION == "yes" ]]; then
        echo ''
        apt autoremove -y
        apt autoclean -y
        apt autopurge -y
        echo "End auto-remove autdated packages."
        exit
    elif [[ $CONFIRMATION == "n" || $CONFIRMATION == "no" ]]; then
        exit
    else
    echo "Please repeat your awnser, put ${bold}(y/n)${reset}"
    fi


#Updating for Fedora_(dnf).
#elif [ "$SO" == "Fedora" ]; then
#    echo "Starting update Fedora.."
#    dnf update
#    dnf full-upgrade -y
#    echo "End updating."

#    echo "You want to auto-remove the outdated packages?(y/n)"
#    if [ $AUTO_CONFIRM == "n" ]; then
#        read CONFIRMATION
#    elif [ $AUTO_CONFIRM == "y" ]; then
#        CONFIRMATION="y"
#    fi

#    if [[ $CONFIRMATION == "y" || $COFIRMATION == "yes" ]]; then
#        echo ''
#        dnf autoremove -y
#        dnf autoclean -y
#        dnf autopurge -y
#        echo "End auto-remove autdated packages."
#        exit
#    elif [[ $CONFIRMATION == "n" || $CONFIRMATION == "no" ]]; then
#        exit
#    else
#    echo "Please repeat your awnser, put ${bold}(y/n)${reset}"
#    fi


#Updating for VoidLinux_(xbps).
#elif [ "$SO" == "voidlinux" ]; then
#    echo "Starting update voidlinux.."
#    xbps-install -Syu    ---(pending for tested)
#    echo "End updating."

#    echo "You want to auto-remove the outdated packages?(y/n)"
#    if [ $AUTO_CONFIRM == "n" ]; then
#        read CONFIRMATION
#    elif [ $AUTO_CONFIRM == "y" ]; then
#        CONFIRMATION="y"
#    fi

#    if [[ $CONFIRMATION == "y" || $COFIRMATION == "yes" ]]; then
#        echo ''
#        xbps-remove -Oo    ---(pending for tested)
#        echo "End auto-remove autdated packages."
#        exit
#    elif [[ $CONFIRMATION == "n" || $CONFIRMATION == "no" ]]; then 
#        exit
#    else
#    echo "Please repeat your awnser, put ${bold}(y/n)${reset}"
#    fi


#Updating for OpenSUSE_(zypper).
#elif [ $SO == "openSUSE" ]; then
#    echo "Starting update openSUSE.."
#    zypper update -y    ---(pending for tested)
#    echo "End updating."

#    echo "You want to auto-remove the outdated packages?(y/n)"
#    if [ $AUTO_CONFIRM == "n" ]; then
#        read CONFIRMATION
#    elif [ $AUTO_CONFIRM == "y" ]; then
#        CONFIRMATION="y"
#    fi

#    if [[ $CONFIRMATION == "y" || $COFIRMATION == "yes" ]]; then
#        zypper clean --all    ---(pending for tested)
#    echo "End auto-remove autdated packages."
#    exit
#    elif [[ $CONFIRMATION == "n" || $CONFIRMATION == "no" ]]; then
#        exit
#    else
#        echo "Please repeat your awnser, put ${bold}(y/n)${reset}"
#    if [ $AUTO_CONFIRM == "n" ]; then
#        read CONFIRMATION
#    elif [ $AUTO_CONFIRM == "y" ]; then
#        CONFIRMATION="y"
#    fi

#    fi


#Updating for Arch_(pacman).
#elif [ $SO == "Arch" ]; then
#    echo "Starting update Arch.."
#    pacman install -Syu    ---(pending for tested)
#    echo "End updating."
#
#    echo "You want to auto-remove the outdated packages?(y/n)"
#    if [ $AUTO_CONFIRM == "n" ]; then
#        read CONFIRMATION
#    elif [ $AUTO_CONFIRM == "y" ]; then
#        CONFIRMATION="y"
#    fi

#    if [[ $CONFIRMATION == "y" || $COFIRMATION == "yes" ]]; then
#        pacman clean --all    ---(pending for tested)
#    echo "End auto-remove autdated packages."
#    exit
#    elif [[ $CONFIRMATION == "n" || $CONFIRMATION == "no" ]]; then
#        exit
#    else
#        echo "Please repeat your awnser, put ${bold}(y/n)${reset}"
#    if [ $AUTO_CONFIRM == "n" ]; then
#        read CONFIRMATION
#    elif [ $AUTO_CONFIRM == "y" ]; then
#        CONFIRMATION="y"
#    fi

#    fi


else
    echo ""
    echo "Your Linux distro, is neither 'Ubuntu' or 'linuxmint' nor 'voidlinux' nor 'openSUSE' nor 'Arch Linux'."
    echo ""
    echo "This program is made for the moment, for the next Linux distros:"
    echo "${bold}Ubuntu${reset}"
    echo "${bold}Linux Mint${reset}"
    #echo "${bold}Fedora${reset}"
    #echo "${bold}OpenSUSE${reset}"
    #echo "${bold}Void Linux${reset}"
    #echo "${bold}Arch Linux${reset}"

fi

#Author: Penguin1866s(https://github.com/Penguin1866s)
