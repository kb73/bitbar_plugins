#!/bin/bash



# open specified app
if [ "$1" = "open" ]; then
    osascript -e "tell application \"$2\" to activate"
    exit
fi

if [ "$(pmset -g | grep "SleepDisabled" | grep -c "1")" -ge 1 ]; then
    echo "☕️"
    echo "---"
    echo "Decaffeinate | bash='$0' param1=open param2=Decaffeinate.app refresh=true terminal=false";

fi

if [ "$(pmset -g | grep "SleepDisabled" | grep -c "0")" -ge 1 ]; then
    echo "?| color=gray"
    echo "---"
    echo "Caffeinate | bash='$0' param1=open param2=Caffeinate.app refresh=true terminal=false";
fi
