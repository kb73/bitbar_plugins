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

### Regular Short Speedtest
echo " | templateImage=$(cat ~/bitbar_plugins/support_files/speedtestIcon.txt)"
echo "---"
output=$(python ~/bitbar_plugins/support_files/speedtest.py)
ping=$(echo "$output" | grep "Hosted" | sed 's/^[^:]*: //') #Gets content after first colon
download=$(echo "$output" | grep "Download:" | sed 's/^[^:]*: //')
upload=$(echo "$output" | grep "Upload:" | sed 's/^[^:]*: //')
echo "Ping: ${ping}"
echo "Down: ${download}"
echo "Up: ${upload}"
echo "---"

echo "Update | refresh=true"
