#!/bin/bash


# *** In the old version this would open an app that had the sudo and osascript lines, but to make this plugin transferrable to others, I just added the code directly here
# open specified app
# if [ "$1" = "open" ]; then
#     osascript -e "tell application \"$2\" to activate"
#     exit
# fi

if [ "$1" = "caffeinate" ]; then
	sudo -S pmset -b sleep 0 && sudo -S pmset -b disablesleep 1
	osascript -e "display notification \"☕️\" with title \"Caffeinated\"" &> /dev/null
	exit
fi

if [ "$1" = "decaffeinate" ]; then
	sudo -S pmset -b sleep 1 && sudo -S pmset -b disablesleep 0
	osascript -e "display notification \"💤\" with title \"Decaf\"" &> /dev/null
fi

if [ "$(pmset -g | grep "SleepDisabled" | grep -c "1")" -ge 1 ]; then
    echo "☕️"
    echo "---"
    echo "Decaffeinate | bash='$0' param1=decaffeinate refresh=true terminal=false";

fi

if [ "$(pmset -g | grep "SleepDisabled" | grep -c "0")" -ge 1 ]; then
    echo "?| color=gray"
    echo "---"
    echo "Caffeinate | bash='$0' param1=caffeinate refresh=true terminal=false";
fi
