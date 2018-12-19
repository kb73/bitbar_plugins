#!/bin/bash

source ~/.custom_commands.sh

notefile=~/Documents/BitBar_Plugins/support_files/notes.txt

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

echo "Notes"
echo "---"

lineNum=1;
while read -r line; do
    echo "$line | color=#6F6F6F bash=$0 param1=copy param2=$lineNum param3=p terminal=false"
    echo "--Delete | bash=$0 param1=delete param2=$lineNum param3=d terminal=false"
    lineNum=$((lineNum+1))
done < ~/Documents/BitBar_Plugins/support_files/notes.txt

echo "---"

echo "New Note | bash=newnote"

if [ -s $notefile ]; then
echo "Clear Notes | color=red"
echo "--I'm sure | bash=$0 param1=clear terminal=false"
fi
