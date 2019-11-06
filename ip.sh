#!/bin/bash

#source ~/.custom_commands.sh <- this was needed when "ip" was the command that was run instead of typing out the code from the command here

# Check to see if wifi interface exists
if [ "$(ifconfig en0 | grep inet )" = "" ]; then
    wifiAddress="not connected"
else
    wifiAddress=$(ifconfig en0 | grep 'inet ' | awk '{print $2}')
fi

# Check to see if ethernet interface exists
if [ "$(ifconfig en5 2> /dev/null | grep inet )" = "" ]; then
    ethernetAddress="not connected"
else
	## if ethernet connected, get address
    ethernetAddress=$(ifconfig en5 | grep 'inet ' | awk '{print $2}')
fi

shortip=$(echo $wifiAddress | cut -d'.' -f 3,4)

echo "$shortip | color=#0000FF"
echo ---

#echo "Send ip | bash=iptodrive terminal=false " <- ip to drive is old function that doesn't work

echo -e "wifi\t\t$wifiAddress"
echo -e "enet\t$ethernetAddress"
echo ---
echo "Refresh | refresh=true"
