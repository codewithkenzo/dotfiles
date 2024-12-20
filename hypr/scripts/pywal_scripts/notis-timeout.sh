#!/bin/sh

focused=false
timeout=2
delay=2
active_window_id="deadd-notification-center"
window_close_command="kill -s USR1 $(pidof deadd-notification-center)"  # Replace with your method to close the window

# Function to handle incoming messages
handle() {
  echo "Received message: $1"  # Debugging: print the incoming message

  case $1 in
    activewindowv2*)
      focused=true
      if [ -n "$active_window_id" ]; then
        # Window became active again, reset state
        echo "Window became active again"
        active_window_id=""
        timeout=$delay
      fi
      ;;
    windowunfocus*)
      focused=false
      if [ -z "$active_window_id" ]; then
        # Capture the ID of the currently active window
        # (Assuming `windowunfocus` message includes the window ID)
        # Adjust the extraction if the message format is different
        active_window_id=$(echo "$1" | awk '{print $NF}')
        echo "Captured window ID: $active_window_id"  # Debugging: print the captured window ID
      fi
      ;;
    *)
      focused=false
      ;;
  esac
}

# Start listening to the socket
socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do
  handle "$line"
  
  if ! $focused && [ -n "$active_window_id" ]; then
    if (( timeout > 0 )); then
      sleep 1
      timeout=$(( timeout - 1 ))
      echo "Timeout countdown: $timeout"  # Debugging: print the remaining timeout
    fi
    
    if (( timeout == 0 )); then
      # Close the window
      echo "Closing window due to inactivity"
      $window_close_command
      active_window_id=""
      # Reset the timeout to start counting again if needed
      timeout=$delay
    fi
  fi
done
