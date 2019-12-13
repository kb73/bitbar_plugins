#!/bin/bash

#source ~/.custom_commands.sh <- this was needed when "ip" was the command that was run instead of typing out the code from the command here

# Set variable 'wifiAddress' to the address of interface en0 (known to be ethernet iface for this mac).
# '2> /dev/null' throws aways any error messages
wifiAddress=$(ipconfig getifaddr en0 2> /dev/null)
if [ $? -eq 1 ]; then

    if [ "$(networksetup -getairportpower en0 | grep off)" = "" ]; then
        wifiAddress="wifi off"
    else
	    # If previous command exited with an error, set 'wifiAddress' to 'not connected'
        wifiAddress="no wifi"
    fi
    
fi

# Set variable 'ethernetAddress' to the address of interface en5 (known to be ethernet iface for this mac).
# '2> /dev/null' throws aways any error messages
ethernetAddress=$(ipconfig getifaddr en5 2> /dev/null)

# If previous command exited with an error, set 'ethernetAddress' to 'not connected'
if [ $? -eq 1 ]; then
    ethernetAddress="not connected"
else
    networksetup -setairportpower en0 off
fi

# If Save option clicked, caffeinate and save wifi address to google_drive/ip.txt
if [ "$1" = "save" ]; then
    sudo -S pmset -b sleep 0 && sudo -S pmset -b disablesleep 1

    # If wifi is off, turn it on
    if [ "$(networksetup -getairportpower en0 | grep On)" = "" ]; then
        networksetup -setairportpower en0 on
        # Wait to set 'wifiAddress' variable until an ip address is available
        while [ "$(ifconfig en0 | grep inet)" = "" ]; do
            sleep 2
        done
        wifiAddress=$(ipconfig getifaddr en0)
    fi
    echo $wifiAddress > ~/google_drive/ip.txt
    open bitbar://refreshPlugin?name=caffeine.5s.sh
fi

shortip=$(echo $wifiAddress | cut -d'.' -f 3,4) # Last 2 #s of wifi ip to display to menu bar

echo "$shortip | color=#0000FF"
echo ---

echo "Save and ☕️ | bash=$0 param1=save terminal=false "
echo ---

#echo "Send ip | bash=iptodrive terminal=false " <- ip to drive is old function that doesn't work

echo -e "wifi\t\t$wifiAddress"
echo -e "enet\t$ethernetAddress"
echo ---
echo "Refresh | refresh=true"

echo ---
echo "Edit plugin | bash=$0 param1=edit terminal=false "
if [ "$1" = "edit" ]; then
    open ~/bitbar_plugins/ip.sh
fi