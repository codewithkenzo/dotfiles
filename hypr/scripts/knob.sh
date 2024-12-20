#!/bin/bash

# Path to the device (replace with your actual device path)
DEVICE="/dev/input/event11" # Replace event3 with your actual event number

# Define the commands for each direction
LEFT_COMMAND="playerctl --player=spotify_player play-pause"
RIGHT_COMMAND="playerctl next"

# Listen for events
/usr/bin/evtest --grab "$DEVICE" | while read -r line; do
  if echo "$line" | grep -q "code 115 (KEY_VOLUMEUP), value 1"; then
    $RIGHT_COMMAND
  elif echo "$line" | grep -q "code 114 (KEY_VOLUMEDOWN), value 1"; then
    $LEFT_COMMAND
  fi
done
