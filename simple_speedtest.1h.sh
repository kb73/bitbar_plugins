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

if [ "$1" = "edit" ]; then
	open "${0}"
fi

if [ "$(ifconfig en0 | grep inet)" = "" ] && [ "$(ifconfig | grep 'en5')" = "" ]; then
    echo "!"
    echo "---"
else
	echo " | templateImage=$(cat ~/bitbar_plugins/support_files/speedtestIcon.txt)" # Show ookla speedtest icon which is stored in speedtestIcon.txt
echo "---"
    # Get complete output from speedtest.py
	output=$(python ~/bitbar_plugins/support_files/speedtest.py 2> /dev/null)

	# Nicely formate results
	# ping=$(echo "$output" | grep "Hosted" | sed 's/^[^:]*: //')
	# download=$(echo "$output" | grep "Download:" | sed 's/^[^:]*: //')
	# upload=$(echo "$output" | grep "Upload:" | sed 's/^[^:]*: //')

	# New and improved formatting (uses 'cut' instead of 'sed')
	ping=$(echo "$output" | grep "Hosted" | cut -d':' -f2)
	download=$(echo "$output" | grep "Download:" | cut -d':' -f2)
	upload=$(echo "$output" | grep "Upload:" | cut -d':' -f2)	

	echo "Ping: ${ping}"
	echo "Down: ${download}"
	echo "Up: ${upload}"
fi


echo "---"

echo "Update | refresh=true"

echo ---
echo "Edit plugin | bash=$0 param1=edit terminal=false "