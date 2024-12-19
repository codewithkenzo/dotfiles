# **1. Create a System Snapshot with Timeshift**
yes | sudo pacman -Sy timeshift
sudo timeshift --create --comments "Initial setup snapshot" --tags D

# **2. GRUB Configuration**
sudo nano /etc/default/grub
# Add the following to GRUB_CMDLINE_LINUX_DEFAULT:
"quiet splash initcall_blacklist=amd_pstate_init amd_pstate.enable=0"

sudo grub-mkconfig -o /boot/grub/grub.cfg

# **3. Remove Power Management Packages**
yes | sudo pacman -Rns upower power-profiles-daemon

# **4. Install System Utilities**
yes | yay -Sy fish kitty zen-browser-bin 7z zip tar nemo curl openssl bluez blueman-git greetd-tuigreet-git \
    atuin zoxide starship pokemon-color-scripts-go vivid fzf


# **5. Install Bun**
curl -fsSL https://bun.sh/install | bash
sudo ln -s $HOME/.bun/bin/bun /usr/local/bin/bun

# **6. Install Rust**
curl https://sh.rustup.rs -sSf | sh

# **7. Install Essential System Packages**
yes | sudo pacman -S libgtop btop dart-sass brightnessctl python \
    gnome-bluetooth-3.0 pacman-contrib gvfs

# **8. Install Hyprland and Desktop Environment**
yes | yay -Sy hyprland-git hyprlock-git hypridle-git xdg-desktop-portal-hyprland-git \
    hyprpicker-git hyprsunset-git pyprland-git swww rofi-wayland wl-clipboard cliphist \
    swayosd-git brightnessctl udiskie howdy devify polkit-gnome playerctl \
    grimblast-git slurp-git python-libevdev
systemctl --user enable --now hypridle.service

# **9. Install Applications**
yes | yay -Sy pavucontrol matugen-bin satty zathura-pdf-mupdf qimgv-light-git \
    mpv-git selectdefaultapplication-fork-git topgrade

# **10. Install Graphics Drivers**
yes | yay -Sy xf86-video-amdgpu vulkan-tools mesa lib32-mesa \
    vulkan-radeon lib32-vulkan-radeon

# **11. Configure Audio**
yes | yay -Sy pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber alsa-utils
systemctl --user enable --now pipewire.service
systemctl --user enable --now pipewire.socket
systemctl --user enable --now wireplumber.service

# **12. Install Qt and Theming Packages**
yes | yay -Sy qt5ct qt5-wayland qt6-wayland nwg-look

# **13. Install Fonts**
yes | yay -Sy ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono \
    ttf-nerd-fonts-symbols-common ttf-font-awesome noto-fonts-cjk ttf-ms-win11-auto
fc-cache -fv

# **14. Install Entertainment Applications**
yes | yay -Sy ani-cli obsidian vesktop-bin telegram-desktop-git stremio-git \
    gpu-screen-recorder-git python-gpustat syncthing-gtk-git kdeconnect-git

# **15. Configure Firewall**
yes | sudo pacman -Syu ufw
sudo ufw enable
sudo systemctl enable ufw
sudo ufw status

# **16. Enable Necessary Services**
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now NetworkManager.service

# ***17. Install Nerd Fonts***
bash -c  "$(curl -fsSL https://raw.githubusercontent.com/officialrajdeepsingh/nerd-fonts-installer/main/install.sh)"
# **17. Testing and Restore (if needed)**
# To test your system, reboot and ensure everything works. If issues occur, restore your snapshot:
sudo timeshift --restore
