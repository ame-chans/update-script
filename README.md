# A (very) poorly-made updating script for Arch
The title's pretty self-explanatory, I'm kind of throwing things together, and trying my absolute best, but I don't consider any of this to be good :3 It really could be done a lot more efficiently and better, but I'll still try my best to keep it "okay-ish" ! Genuinely, though, I wouldn't recommend this to anyone, as it's super jank, hastily thrown together, and kind of lacking :3 At this point, setting a reminder on your phone is cleaner - and simpler...

## Warning depending on the place where you put the .service file !!!
If the .service and .timer are in the `.config/systemd/user` directory, then you'll need to edit your sudoers file ! You'll have to add this line to your sudoers file by running `sudo visudo`: `<username> ALL=(ALL) NOPASSWD: /usr/bin/pacman, /usr/bin/yay
`
If, however, you put your .service and .timer files in the `/etc/systemd/system` directory, notifications will not work, because commands are all ran as root, and root doesn't have a graphical session open. Thus, it'll update packages, but it'll never display notifications, and it'll exit with a fail if you check with `systemctl status update-pkgs.service`.
