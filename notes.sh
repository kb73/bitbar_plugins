#!/bin/bash

# Ensure notes.txt exists
touch ~/bitbar_plugins/support_files/notes.txt

# Create variable for notes.txt file so we don't have to type the full path everytime we want to use it
notefile=~/bitbar_plugins/support_files/notes.txt

# Create variable which refreshes only the notes.sh plugin
refresh="open bitbar://refreshPlugin?name=notes.sh"

# Function to delete the selected note
if [ "$1" = "delete" ]; then
    # equivalent to: sed -i '' <linenumber>d ~/bitbar_plugins/support_files/notes.txt
    sed -i '' $2$3 $notefile
    $refresh
fi

# Function to copy note to clipboard
## Note: for some unknown reason, it adds a new line character (\n) to the end of what is copied
if [ "$1" = "copy" ]; then
    sed -n $2$3 $notefile | pbcopy
fi

# Function that overrites the notes.txt file with nothing, clearing all notes
if [ "$1" = "clear" ]; then
    > $notefile
    $refresh
fi

# Function to create new note
if [ "$1" = "new" ]; then
    # Opens a system dialog box and saves input to notes file
	osascript -e 'Tell application "System Events" to display dialog "New Note:" default answer "" ' -e 'text returned of result' >>$notefile
	$refresh
fi

echo "Notes"
echo "---"

# variable to track which line is being read
lineNum=1;

# Read through every line of the file
while read -r line; do
    echo "$line | color=#6F6F6F bash=$0 param1=copy param2=$lineNum param3=p terminal=false"
    echo "--Delete | bash=$0 param1=delete param2=$lineNum param3=d terminal=false"
    lineNum=$((lineNum+1))
done < $notefile

echo "---"
echo "New Note | bash=$0 param1=new terminal=false"

# Function which only displays the option to clear notes if at least one note exists
if [ -s $notefile ]; then
echo "Clear Notes | color=red"
echo "--I'm sure | bash=$0 param1=clear terminal=false"
fi


