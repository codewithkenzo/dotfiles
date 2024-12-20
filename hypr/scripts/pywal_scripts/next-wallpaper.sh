#!/bin/bash

export PATH=$HOME/.local/share/cargo/bin:$PATH

# Configuration
WALLPAPER_DIR="$HOME/Pictures/walls-main/anime/" HISTORY_FILE="$HOME/.wallpaper_history"

# Function to kill existing Waybar instances and start a new one
start_waybar() {
  echo "Killing existing Waybar instances."
  pkill waybar 2>/dev/null
  echo "Starting Waybar."
  waybar -c "$HOME/.config/waybar/config" -s "$HOME/.config/waybar/style.css" &
}

# Function to update colors
update_colors() {
  echo "Running update-colors.sh script."
  /home/kenzo/.config/mako/update-colors.sh
  echo "Updating pywalfox."
  sudo pywalfox update
}

# Get a list of wallpaper files
PICS=($(ls "$WALLPAPER_DIR"))

# Check if there are wallpapers available
if [ ${#PICS[@]} -eq 0 ]; then
  echo "No wallpapers found in $WALLPAPER_DIR."
  exit 1
fi

# Function to set wallpaper and update history
set_wallpaper() {
  local wallpaper_path="$1"
  echo "Setting wallpaper: $wallpaper_path"

  # Set the wallpaper using swww (uncomment and adjust as needed)
  #swww img "$wallpaper_path" --transition-type wipe --transition-fps 100 --transition-duration 1.0 --transition-pos 0.810,0.972 --transition-bezier 0.65,0,0.35,1 --transition-step 255

  # Generate colors using pywal
  echo "Generating colors with pywal."
  wal --backend colorz --saturate 0.5 -i "$wallpaper_path"

  echo "Sending colorscheme command to Neovim."
  nvr --server $NVIM_SOCKET --remote-send '<ESC>:colorscheme pywal16<CR>'

  # Update colors and restart waybar
  update_colors
  start_waybar

  # Update history
  echo "$wallpaper_path" >>"$HISTORY_FILE"
}

# Function to go to the next wallpaper
next_wallpaper() {
  local random_pic=${PICS[$RANDOM % ${#PICS[@]}]}
  local wallpaper_path="${WALLPAPER_DIR}/${random_pic}"
  set_wallpaper "$wallpaper_path"
}

# Set the next wallpaper
next_wallpaper
swaync-client -rs
