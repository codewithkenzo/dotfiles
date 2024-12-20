#!/bin/bash

# Get the class of the active window
ACTIVE_WINDOW_CLASS=$(hyprctl activewindow -j | jq -r ".class")

# Check if the active window class is Steam, steam_app, or Overwatch
if [[ "$ACTIVE_WINDOW_CLASS" == "Steam" || "$ACTIVE_WINDOW_CLASS" == "steam_app" || "$ACTIVE_WINDOW_CLASS" == "Overwatch" ]]; then
  # If the active window is Steam, steam_app, or Overwatch, unmap the window
  hyprctl dispatch windowunmap "$(hyprctl activewindow -j | jq -r ".address")"
else
  # Check if the active window class is Nautilus
  if [[ "$ACTIVE_WINDOW_CLASS" == "Nautilus" ]]; then
    # Get the version of Nautilus
    NAUTILUS_VERSION=$(nautilus --version | grep -oP '\d+(\.\d+)+')

    # Specify your condition based on the Nautilus version
    # For example, you might only want to kill if the version is greater than a specific version
    REQUIRED_VERSION="3.30.0"

    # Compare versions
    if [[ "$(printf '%s\n' "$NAUTILUS_VERSION" "$REQUIRED_VERSION" | sort -V | head -n1)" == "$REQUIRED_VERSION" ]]; then
      echo "Nautilus version is greater than or equal to $REQUIRED_VERSION. Killing Nautilus."
      pkill nautilus
    else
      echo "Nautilus version is less than $REQUIRED_VERSION. Not killing Nautilus."
    fi
  else
    # If the active window is not Steam, steam_app, Overwatch, or Nautilus, kill the active window
    hyprctl dispatch killactive ""
  fi
fi
