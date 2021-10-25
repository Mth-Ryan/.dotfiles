#! /usr/bin/env bash

LOADING="Searching for Network connections\0icon\x1fvcs-update-required"
CONFIRMATION="Disconnect\0icon\x1fvcs-normal\nCancel\0icon\x1fvcs-conflicting"

FLAGS="-dmenu -show-icons"
ATHEME="-theme ~/.config/rofi/alert-theme.rasi"
MTHEME="-theme ~/.config/rofi/wifi-theme.rasi"
ITHEME="-theme ~/.config/rofi/input-theme.rasi"
CTHEME="-theme ~/.config/rofi/confirm-theme.rasi"

echo -en $LOADING | rofi $FLAGS $ATHEME & #Loading window in background
LOADPID=$! #Pid

# Fetch the SSIDs
OPTIONS=$(python3 "$HOME/.config/rofi/wifi-utils.py" | cut -d "'" -f2)

kill $LOADPID 2> /dev/null #Kill Loading window

# SSID selection window
SSID=$(echo -en $OPTIONS | rofi $FLAGS $MTHEME)

if [[ $SSID == "" ]]; then
    exit 1
fi

if [[ $SSID == *"(Connected)"* ]]; then
    CONFIRM=$(echo -en $CONFIRMATION | rofi $FLAGS $CTHEME)
    if [[ $CONFIRM == Disconnect ]]; then
        WIFI=$(echo $SSID | sed 's/ (Connected)//g')
        nmcli con down id $WIFI
        exit 0
    else
        exit 0
    fi
fi

PASSWD=$(rofi $FLAGS -password -p "Password:" $ITHEME)

if [[ $PASSWD == "" ]]; then
    LOG=$(nmcli d wifi connect $SSID 2>&1)
else
    LOG=$(nmcli d wifi connect $SSID password $PASSWD 2>&1)
fi

while [[ $LOG == *"Secrets were required"* ]]; do
    PASSWD=$(rofi $FLAGS -password -p "Password:" $ITHEME)
    if [[ $PASSWD == "" ]]; then
        exit 1
    fi
    LOG=$(nmcli d wifi connect $SSID password $PASSWD 2>&1)
done
