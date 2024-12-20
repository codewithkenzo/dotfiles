#!/bin/bash

# Use expect to wrap around sudo to capture the password prompt
expect <<EOF
set timeout -1

spawn sudo -v
expect {
    "password for" {
        # Send a notification when the password prompt is detected
        exec notify-send "Sudo Password Prompt" "Please enter your sudo password in the terminal."
        interact
    }
}
EOF
