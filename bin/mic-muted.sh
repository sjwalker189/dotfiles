#!/bin/sh

# Get active audio source index
CURRENT_SOURCE=$(pactl info | grep "Default Source" | cut -f3 -d" ")

# List lines in pactl after the source name match and pick mute status



if [ $(
pactl list sources | grep -A 10 $CURRENT_SOURCE | grep "Mute: yes" 
)  ]
then
  echo " 󰍭 Muted" # Muted Icon (Install Some icon pack like feather, nerd-fonts)
else
  echo " 󰍬 ON " # Unmuted Icon (Install Some icon pack like feather, nerd-fonts)
fi
