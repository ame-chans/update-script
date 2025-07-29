#!/bin/bash
# A very, very barebones script that takes care of updating my packages on my install.
# A .timer and .service file are also included, to let you enable and use it hourly, in order to not forget to update packagesi
# So far, we have notifications based on whether or not packages were updated.

DATE=$(date -I)
HOUR=$(date +%H)
TIME=$(date +%R+%S)
pkgsatruntime=$(cat /var/log/pacman.log | grep $DATE | grep $HOUR | grep "upgraded" | cut -d " " -f 4)
pkgstotal=$(cat /var/log/pacman.log | grep $DATE | grep "upgraded" | cut -d " " -f 4)

echo "Updating packages: pacman"
sudo pacman -Syyu --noconfirm
echo "Updating packages: AUR"
yay -Syyu --needed --noconfirm

if [ -z "${pkgs// }" ] ; then
	notify-send -t 5000 "Update script" "No packages were updated at $TIME."
        notify-send -t 10000 "Update script" "Packages updated today: $pkgstotal"
	exit
else
	echo "The packages updated at" $TIME "are" $pkgs ". Please check https://archlinux.org/news/ for any manual interventions that may be required !" > $HOME/pkgs-updated
	pkgsnotify=$(cat $HOME/pkgs-updated)
	notify-send -t 10000 "Update script" "$pkgsnotify"
	notify-send -t 10000 "Update script" "Packages updated today: $pkgstotal"
fi
