#!/usr/bin/sh

# No need to display notification if screen is locked
SCREEN_LOCKED=$(gdbus call --session --dest org.freedesktop.ScreenSaver --object-path /org/freedesktop/ScreenSaver --method org.freedesktop.ScreenSaver.GetActive | grep -q "true" && echo 1 || echo 0)
if [[ "$SCREEN_LOCKED" == "1" ]]; then
    exit 0
fi

# Obtain your device ID: kdeconnect-cli --list-devices
DEVICE_ID=d97803a897b59e47
LOW_BATTERY_PERCENTAGE=70

is_charging=$(qdbus org.kde.kdeconnect.daemon /modules/kdeconnect/devices/"$DEVICE_ID"/battery org.kde.kdeconnect.device.battery.isCharging)
device_name=$(qdbus org.kde.kdeconnect /modules/kdeconnect/devices/"$DEVICE_ID" org.kde.kdeconnect.device.name)
battery_percentage=$(qdbus org.kde.kdeconnect.daemon /modules/kdeconnect/devices/"$DEVICE_ID"/battery org.kde.kdeconnect.device.battery.charge)

if [ "$battery_percentage " -lt "$LOW_BATTERY_PERCENTAGE" ] && [ $is_charging = "false" ] && [ "$battery_percentage" -gt 1 ]
then
	notify-send -u low -t 4000 -c device --app-name="KDE Connect" -i battery "$device_name" "Connect the phone to the charger. Battery level: $battery_percentage %"
fi

if [ "$battery_percentage" -eq 100 ] && [ "$is_charging" ]
then
	notify-send -u low -t 4000 -c device --app-name="KDE Connect" -i battery "$device_name" "Battery fully charged."
fi
