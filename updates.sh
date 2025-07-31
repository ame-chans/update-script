#!/bin/bash
# A very, very barebones script that takes care of updating my packages on my install
# A .timer and .service file are also included, to let you enable and use it hourly, in order to not forget to update packages
# Very basic notifications system to inform, and there's a file that lists packages updated/upgraded

DATE=$(date -I)
HOUR=$(date +%H)
TIME=$(date +%R+%S)

# Upgrading packages
sudo pacman -Syyu --noconfirm
yay -Syyu --needed --noconfirm

# Obtaining the list of packages for the day, and even for the day and at the hour it's run
pkgsatruntime=$(cat /var/log/pacman.log | grep $DATE | grep $HOUR | grep "upgraded" | cut -d " " -f 4)
pkgstotal=$(cat /var/log/pacman.log | grep $DATE | grep "upgraded" | cut -d " " -f 4)

# Notification system, where it notifies based off the contents of the pkgs variable:
# If the variable has an empty space (nothing is updated), then it displays a notification that states nothing was updated.
if [ -z "${pkgs// }" ] ; then
	notify-send -t 5000 "Update script" "No packages were updated at $TIME."
        notify-send -t 10000 "Update script" "Packages updated today: $pkgstotal"
else
	echo "The packages updated at" $TIME "are" $pkgs ". Please check https://archlinux.org/news/ for any manual interventions that may be required !" > $HOME/pkgs-updated
	pkgsnotify=$(cat $HOME/pkgs-updated)
	notify-send -t 10000 "Update script" "$pkgsnotify"
	notify-send -t 10000 "Update script" "Packages updated today: $pkgstotal"
fi

# Writing the packages of the day, all being written to a file so you can check on a daily basis.
echo $DATE $pkgstotal >> $HOME/pkgs-updated-total
