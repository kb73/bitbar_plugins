#!/bin/bash


# *** In the old version this would open an app that had the sudo and osascript lines, but to make this plugin transferrable to others, I just added the code directly here
# open specified app
# if [ "$1" = "open" ]; then
#     osascript -e "tell application \"$2\" to activate"
#     exit
# fi

# Function to make computer not sleep and continue processes even if lid is closed suddenly
## Note: this will kill battery life as your computer is constantly on
if [ "$1" = "caffeinate" ]; then
	sudo -S pmset -b sleep 0 && sudo -S pmset -b disablesleep 1
	osascript -e "display notification \"☕️\" with title \"Caffeinated\"" &> /dev/null
	exit
fi

# Function to undo 'caffeinate'
if [ "$1" = "decaffeinate" ]; then
	sudo -S pmset -b sleep 1 && sudo -S pmset -b disablesleep 0
	osascript -e "display notification \"💤\" with title \"Decaf\"" &> /dev/null
fi

# Check to see whether caffeine is enabled and displays the appropriate options
if [ "$(pmset -g | grep "SleepDisabled" | grep -c "1")" -ge 1 ]; then
    echo "☕️"
    echo "---"
    echo "Decaffeinate | bash='$0' param1=decaffeinate refresh=true terminal=false";

fi

# Check to see whether caffeine is enabled and displays the appropriate options
if [ "$(pmset -g | grep "SleepDisabled" | grep -c "0")" -ge 1 ]; then
    echo "C | color=gray"
    echo "---"
    echo "Caffeinate | bash='$0' param1=caffeinate refresh=true terminal=false";
fi

echo ---
echo "Edit plugin | bash=$0 param1=edit terminal=false "
if [ "$1" = "edit" ]; then
    open "${0}"
fi
