#!/bin/bash

# A very, very barebones script that takes care of updating my packages on my install.
# A .timer and .service file are also included, to let you enable and use it hourly, in order to not forget to update packages
# To-Do : Eventually list packages that are updated (pacman logs), then also add a notification system ? Or try to, at least.
# I'd ideally also add notifications for failures, or for anything that requires manual intervention, which would be a lot trickier.

echo "Updating packages: pacman"
sudo pacman -Syyu --noconfirm
echo "Updating packages: AUR"
yay -Syyu --needed --noconfirm
