#!/bin/bash
cap=$(system_profiler SPPowerDataType | grep Capacity | cut -d':' -f2 | tr -d " ")
chg=$(system_profiler SPPowerDataType | grep Remaining | cut -d':' -f2 | tr -d " ")
pct=$(echo "scale=1; $chg * 100 / $cap" | bc -l)
floor=$(echo ${pct%.*})
cAdjust=$(echo "220-5*(40-$floor)" | bc -l)
if [ "$(pmset -g ac | grep No)" = "" ]; then
	color=#00FF00
else
	if [ $floor -ge 40 ]; then
		color=#FFFFFF
	else
		g=$(printf "%02x" $cAdjust)
		color='#ff'$g'00'
	fi
fi
echo "$pct% | size=13 color=$color"

echo ---
echo "Edit plugin | bash=$0 param1=edit terminal=false "
if [ "$1" = "edit" ]; then
    open ~/bitbar_plugins/batterypercentage.3s.sh
fi