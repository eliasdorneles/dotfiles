#!/bin/bash

# enables focus-follow-mouse
gsettings set org.gnome.desktop.wm.preferences focus-mode "mouse"

# disable Ctrl-Alt-S
gsettings set org.gnome.desktop.wm.keybindings toggle-shaded "['<Control><Super>s']"

# setup workspace switch shortcuts
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Control>F1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Control>F2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Control>F3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Control>F4']"
