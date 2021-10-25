#! /usr/bin/env bash

OPTIONS="Leave\0icon\x1fsystem-log-out\nRestart\0icon\x1fsystem-restart\nShut Down\0icon\x1fsystem-shut-down"
CONFIRMATION="Continue\0icon\x1fvcs-normal\nCancel\0icon\x1fvcs-conflicting"

FLAGS="-dmenu -show-icons"
MTHEME="-theme ~/.config/rofi/powermenu-theme.rasi"
CTHEME="-theme ~/.config/rofi/confirm-theme.rasi"

ACTION=$(echo -en $OPTIONS | rofi $FLAGS $MTHEME)
if [[ $ACTION != "" ]]; then
    CONFIRM=$(echo -en $CONFIRMATION | rofi $FLAGS $CTHEME)
    if [[ $CONFIRM == "Continue" ]]; then
        case $ACTION in
            "Leave")     loginctl terminate-user $USER;;
            "Restart")   systemctl reboot ;;
            "Shut Down") systemctl poweroff ;;
            *)           echo "Ivalid Option";;
        esac
    fi
fi
