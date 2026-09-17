# mylinuxconfig

# How to dump the extensions config 

dconf dump /org/gnome/shell/extensions/ > ubuntu_extension_config.txt

# How to load the extensions config

dfconf load /org/gnome/shell/extensions/ < ubuntu_extension_config.txt
