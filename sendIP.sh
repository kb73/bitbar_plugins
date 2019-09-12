#!/bin/bash

#source ~/.custom_commands.sh

echo "ip"
echo "---"
#echo "Send ip | bash=iptodrive terminal=false "
#echo "---"
# Check to see if wifi interface exists
    if [ "$(ifconfig | grep 'en0')" = "" ]; then
        wifiAddress="not connected"
    else
        wifiAddress=$(ifconfig en0 | grep 'inet ' | awk '{print $2}')
    fi

    # Check to see if ethernet interface exists
    if [ "$(ifconfig | grep 'en12')" = "" ]; then
        ethernetAddress="not connected"
    else
        ethernetAddress=$(ifconfig en12 | grep 'inet ' | awk '{print $2}')
    fi

	echo -e "wifi\t\t$wifiAddress"
	echo -e "enet\t$ethernetAddress"
