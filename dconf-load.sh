#!/usr/bin/env bash
# Load the GNOME settings in ./dconf/ into the current user's dconf.
# Install the extensions listed in the README first.
set -euo pipefail
cd "$(dirname "$0")/dconf"

dconf load /org/gnome/shell/extensions/                   < extensions.txt
dconf load /org/gnome/desktop/wm/keybindings/             < wm-keybindings.txt
dconf load /org/gnome/desktop/wm/preferences/             < wm-preferences.txt
dconf load /org/gnome/mutter/                             < mutter.txt
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < media-keys.txt
gsettings set org.gnome.shell enabled-extensions          "$(cat enabled-extensions.txt)"
gsettings set org.gnome.shell disabled-extensions         "$(cat disabled-extensions.txt)"

echo "Loaded. Log out and back in to apply everything."
