#!/bin/bash
#
# Ookla speed test, using speedtest-cli (https://github.com/sivel/speedtest-cli)
#
# <bitbar.title>Simple Speedtest</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Kevin Bowers</bitbar.author>
# <bitbar.author.github>kevinbowers73</bitbar.author.github>
# <bitbar.desc>Simple Ookla speed test which uses https://speedtest.net via speedtest-cli</bitbar.desc>
# <bitbar.dependencies>speedtest-cli</bitbar.dependencies>
# <bitbar.image>N/A</bitbar.image>
#
# Dependencies: 
#   speedtest-cli (https://github.com/sivel/speedtest-cli)

### Speedtest with Check to see if WIFI is turned on
#wifi=$(networksetup -getairportpower en0 | awk '{print $4}')
#
#if [ $wifi = "On" ]; then
#    echo " | templateImage=$(cat ~/Documents/BitBarPlugins-Unused/Support\ Images/speedtestIcon.txt)"
#    echo "---"
#    speedtest short
#    echo "---"
#fi
#
#if [ $wifi = "Off" ]; then
#    echo "X"
#    echo "---"
#fi

### Displays truncated results of Ookla speedtest

# Show ookla speedtest icon which is stored in speedtestIcon.txt


if [ "$(ifconfig en0 | grep inet)" = "" ] && [ "$(ifconfig | grep 'en5')" = "" ]; then
    echo "!"
    echo "---"
else
	echo " | templateImage=$(cat ~/bitbar_plugins/support_files/speedtestIcon.txt)"
echo "---"
    # Get complete output from speedtest.py
	output=$(python ~/bitbar_plugins/support_files/speedtest.py 2> /dev/null)

	# Nicely formate results
	ping=$(echo "$output" | grep "Hosted" | sed 's/^[^:]*: //') #Gets content after first colon
	download=$(echo "$output" | grep "Download:" | sed 's/^[^:]*: //')
	upload=$(echo "$output" | grep "Upload:" | sed 's/^[^:]*: //')

	echo "Ping: ${ping}"
	echo "Down: ${download}"
	echo "Up: ${upload}"
fi


echo "---"

echo "Update | refresh=true"

echo ---
echo "Edit plugin | bash=$0 param1=edit terminal=false "
if [ "$1" = "edit" ]; then
    open ~/bitbar_plugins/simple_speedtest.1h.sh
fi