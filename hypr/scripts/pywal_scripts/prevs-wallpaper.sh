#!/bin/bash

# Configuration
WALLPAPER_DIR="$HOME/Pictures/walls-main/anime/"
NOTIFY_COMMAND="notify-send" # Command for sending notifications
HISTORY_FILE="$HOME/.wallpaper_history"

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

# Function to set wallpaper and update history
set_wallpaper() {
    local wallpaper_path="$1"
    echo "Setting wallpaper: $wallpaper_path"

    # Set the wallpaper using swww (uncomment and adjust as needed)
    #swww img "$wallpaper_path" --transition-type wipe --transition-fps 100 --transition-duration 1.0 --transition-pos 0.810,0.972 --transition-bezier 0.65,0,0.35,1 --transition-step 255

    # Generate colors using pywal
    echo "Generating colors with pywal."
    wal --backend colorz --saturate -0.18 -i "$wallpaper_path"

    # Update colors and restart waybar
    update_colors
    start_waybar

    # Update history
    echo "$wallpaper_path" >> "$HISTORY_FILE"
}

# Function to get the last wallpaper from history
get_last_wallpaper() {
    tail -n 2 "$HISTORY_FILE" | head -n 1
}

# Function to go to the previous wallpaper
previous_wallpaper() {
    local last_wallpaper=$(get_last_wallpaper)
    if [ -z "$last_wallpaper" ]; then
        echo "No previous wallpaper found."
        exit 1
    fi
    sed -i '$d' "$HISTORY_FILE"
    set_wallpaper "$last_wallpaper"
}

# Set the previous wallpaper
previous_wallpaper
