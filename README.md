# KDE Connect battery warning

You have poor-ass phone with battery for 1,5h SoC? Still forgeting about charging and ended with dead battery on a party? Here we go, with my script.

# Okay, but what do i need?

1. Installed notify-send (default KDE notification daemon)
2. Installed KDE Connect - on your phone and PC
3. Paired phone and PC.

`git clone https://github.com/EXCV31/kdeconnect-battery-warning.git`

`cd kdeconnect-battery-warning/`

`nano kdeconnect-battery.sh`

Fill variable DEVICE_ID with your... device id. You can obtain it by:

`kdeconnect-cli --list-devices`

And if you want - write your own battery percentage level, when you want to get a warning - in variable LOW_BATTERY_PERCENTAGE

# How i can use that?

Put script in /usr/local/bin and bind command below to keyboard shortcut via "own shortcuts". I use "PAUSE" button.

`sh /usr/local/bin/kdeconnect-battery.sh`

If you want to get this work with cron (i don't know to be honest how run notify-send in cron, so i use clicking PAUSE button every time instead running a script):

`*/1 * * * * your_username export DISPLAY=:0;xdotool key 0xff13` - Every minute click PAUSE and run script.


Tested on Xiaomi Redmi Note 8 Pro & EndeavourOS 5.15.10-arch1-1
