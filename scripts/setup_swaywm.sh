sudo apt install sway swaylock swayidle waybar rofi

# Detect and controll media players (e.g. Spotify, Chrome video, etc)
sudo apt install playerctl

# TODO: Automate this
# Backlight support
# Install https://gitlab.com/wavexx/acpilight
# Add user to "video" group
sudo usermod -a -G video $USER
# logout -> login -> can now use "xbacklight -inc / -dec"
