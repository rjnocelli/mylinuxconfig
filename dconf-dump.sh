#!/usr/bin/env bash
# Dump the GNOME settings tracked by this repo into ./dconf/
set -euo pipefail
cd "$(dirname "$0")/dconf"

dconf dump /org/gnome/shell/extensions/                   > extensions.txt
dconf dump /org/gnome/desktop/wm/keybindings/             > wm-keybindings.txt
dconf dump /org/gnome/desktop/wm/preferences/             > wm-preferences.txt
dconf dump /org/gnome/mutter/                             > mutter.txt
dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > media-keys.txt
gsettings get org.gnome.shell enabled-extensions          > enabled-extensions.txt
gsettings get org.gnome.shell disabled-extensions         > disabled-extensions.txt

echo "Dumped to $(pwd)"
