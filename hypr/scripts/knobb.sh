#!/bin/bash

# Path to the device (replace with your actual device path)
DEVICE="/dev/input/eventX" # Replace eventX with your actual event number

# Define the commands for each direction
# For Wayland, use compositor-specific commands if available
LEFT_COMMAND="swaymsg media previous" # Replace with appropriate command
RIGHT_COMMAND="swaymsg media next"    # Replace with appropriate command

# Listen for events
/usr/bin/evtest --grab "$DEVICE" | while read -r line; do
  if echo "$line" | grep -q "code 115 (KEY_VOLUMEUP), value 1"; then
    $RIGHT_COMMAND
  elif echo "$line" | grep -q "code 114 (KEY_VOLUMEDOWN), value 1"; then
    $LEFT_COMMAND
  fi
done
