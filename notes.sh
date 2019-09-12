#!/bin/bash

touch ~/Documents/bitbar_plugins/support_files/notes.txt

notefile=~/Documents/bitbar_plugins/support_files/notes.txt

refresh="open bitbar://refreshPlugin?name=notes.sh"

if [ "$1" = "delete" ]; then
    sed -i '' $2$3 $notefile
    $refresh
fi

if [ "$1" = "copy" ]; then
    sed -n $2$3 $notefile | pbcopy
fi

if [ "$1" = "clear" ]; then
    > $notefile
    $refresh
fi

if [ "$1" = "new" ]; then
	osascript -e 'Tell application "System Events" to display dialog "New Note:" default answer "" ' -e 'text returned of result' >>~/Documents/bitbar_plugins/support_files/notes.txt
	open bitbar://refreshPlugin?name=notes.sh
fi

echo "Notes"
echo "---"

lineNum=1;
while read -r line; do
    echo "$line | color=#6F6F6F bash=$0 param1=copy param2=$lineNum param3=p terminal=false"
    echo "--Delete | bash=$0 param1=delete param2=$lineNum param3=d terminal=false"
    lineNum=$((lineNum+1))
done < ~/Documents/bitbar_plugins/support_files/notes.txt

echo "---"

echo "New Note | bash=$0 param1=new terminal=false"

if [ -s $notefile ]; then
echo "Clear Notes | color=red"
echo "--I'm sure | bash=$0 param1=clear terminal=false"
fi


