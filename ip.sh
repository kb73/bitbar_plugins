#!/bin/bash

#source ~/.custom_commands.sh <- this was needed when "ip" was the command that was run instead of typing out the code from the command here

# Set variable 'wifiAddress' to the address of interface en0 (known to be ethernet iface for this mac).
# '2> /dev/null' throws aways any error messages
wifiAddress=$(ipconfig getifaddr en0 2> /dev/null)
if [ $? -eq 1 ]; then

	# If previous command exited with an error, set 'wifiAddress' to 'not connected'
    wifiAddress="not connected"
fi

# Set variable 'ethernetAddress' to the address of interface en5 (known to be ethernet iface for this mac).
# '2> /dev/null' throws aways any error messages
ethernetAddress=$(ipconfig getifaddr en5 2> /dev/null)

# If previous command exited with an error, set 'ethernetAddress' to 'not connected'
if [ $? -eq 1 ]; then
    ethernetAddress="not connected"
fi

shortip=$(echo $wifiAddress | cut -d'.' -f 3,4) # Last 2 #s of wifi ip to display to menu bar

echo "$shortip | color=#0000FF"
echo ---

#echo "Send ip | bash=iptodrive terminal=false " <- ip to drive is old function that doesn't work

echo -e "wifi\t\t$wifiAddress"
echo -e "enet\t$ethernetAddress"
echo ---
echo "Refresh | refresh=true"
