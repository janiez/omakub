#!/bin/bash

packages=(gnome-shell-extension-manager gir1.2-gtop-2.0)
# gir1.2-clutter-1.0 is not available on all Debian 13 releases
if apt-cache show gir1.2-clutter-1.0 >/dev/null 2>&1; then
  packages+=(gir1.2-clutter-1.0)
fi
sudo apt install -y "${packages[@]}"
pipx install gnome-extensions-cli --system-site-packages

disable_extension_if_installed() {
  local extension_id="$1"
  if gnome-extensions list | grep -qx "$extension_id"; then
    gnome-extensions disable "$extension_id"
  fi
}

copy_schema_if_exists() {
  local schema_path="$1"
  if [ -f "$schema_path" ]; then
    sudo cp "$schema_path" /usr/share/glib-2.0/schemas/
  fi
}

set_if_schema_exists() {
  local schema="$1"
  local key="$2"
  local value="$3"
  if gsettings list-schemas | grep -qx "$schema"; then
    gsettings set "$schema" "$key" "$value"
  fi
}

# Turn off default Debian GNOME extensions if present
disable_extension_if_installed ding@rastersoft.com

# Pause to assure user is ready to accept confirmations
gum confirm "To install Gnome extensions, you need to accept some confirmations. Ready?"

# Install new extensions
gext install tactile@lundal.io || true
gext install just-perfection-desktop@just-perfection || true
gext install blur-my-shell@aunetx || true
gext install space-bar@luchrioh || true
gext install undecorate@sun.wxg@gmail.com || true
gext install tophat@fflewddur.github.io || true
gext install AlphabeticalAppGrid@stuarthayhurst || true

# Compile gsettings schemas in order to be able to set them
copy_schema_if_exists "$HOME/.local/share/gnome-shell/extensions/tactile@lundal.io/schemas/org.gnome.shell.extensions.tactile.gschema.xml"
copy_schema_if_exists "$HOME/.local/share/gnome-shell/extensions/just-perfection-desktop@just-perfection/schemas/org.gnome.shell.extensions.just-perfection.gschema.xml"
copy_schema_if_exists "$HOME/.local/share/gnome-shell/extensions/blur-my-shell@aunetx/schemas/org.gnome.shell.extensions.blur-my-shell.gschema.xml"
copy_schema_if_exists "$HOME/.local/share/gnome-shell/extensions/space-bar@luchrioh/schemas/org.gnome.shell.extensions.space-bar.gschema.xml"
copy_schema_if_exists "$HOME/.local/share/gnome-shell/extensions/tophat@fflewddur.github.io/schemas/org.gnome.shell.extensions.tophat.gschema.xml"
copy_schema_if_exists "$HOME/.local/share/gnome-shell/extensions/AlphabeticalAppGrid@stuarthayhurst/schemas/org.gnome.shell.extensions.AlphabeticalAppGrid.gschema.xml"
sudo glib-compile-schemas /usr/share/glib-2.0/schemas/

# Configure Tactile
set_if_schema_exists org.gnome.shell.extensions.tactile col-0 1
set_if_schema_exists org.gnome.shell.extensions.tactile col-1 2
set_if_schema_exists org.gnome.shell.extensions.tactile col-2 1
set_if_schema_exists org.gnome.shell.extensions.tactile col-3 0
set_if_schema_exists org.gnome.shell.extensions.tactile row-0 1
set_if_schema_exists org.gnome.shell.extensions.tactile row-1 1
set_if_schema_exists org.gnome.shell.extensions.tactile gap-size 32

# Configure Just Perfection
set_if_schema_exists org.gnome.shell.extensions.just-perfection animation 2
set_if_schema_exists org.gnome.shell.extensions.just-perfection dash-app-running true
set_if_schema_exists org.gnome.shell.extensions.just-perfection workspace true
set_if_schema_exists org.gnome.shell.extensions.just-perfection workspace-popup false

# Configure Blur My Shell
set_if_schema_exists org.gnome.shell.extensions.blur-my-shell.appfolder blur false
set_if_schema_exists org.gnome.shell.extensions.blur-my-shell.lockscreen blur false
set_if_schema_exists org.gnome.shell.extensions.blur-my-shell.screenshot blur false
set_if_schema_exists org.gnome.shell.extensions.blur-my-shell.window-list blur false
set_if_schema_exists org.gnome.shell.extensions.blur-my-shell.panel blur false
set_if_schema_exists org.gnome.shell.extensions.blur-my-shell.overview blur true
set_if_schema_exists org.gnome.shell.extensions.blur-my-shell.overview pipeline 'pipeline_default'
set_if_schema_exists org.gnome.shell.extensions.blur-my-shell.dash-to-dock blur true
set_if_schema_exists org.gnome.shell.extensions.blur-my-shell.dash-to-dock brightness 0.6
set_if_schema_exists org.gnome.shell.extensions.blur-my-shell.dash-to-dock sigma 30
set_if_schema_exists org.gnome.shell.extensions.blur-my-shell.dash-to-dock static-blur true
set_if_schema_exists org.gnome.shell.extensions.blur-my-shell.dash-to-dock style-dash-to-dock 0

# Configure Space Bar
set_if_schema_exists org.gnome.shell.extensions.space-bar.behavior smart-workspace-names false
set_if_schema_exists org.gnome.shell.extensions.space-bar.shortcuts enable-activate-workspace-shortcuts false
set_if_schema_exists org.gnome.shell.extensions.space-bar.shortcuts enable-move-to-workspace-shortcuts true
set_if_schema_exists org.gnome.shell.extensions.space-bar.shortcuts open-menu "@as []"

# Configure TopHat
set_if_schema_exists org.gnome.shell.extensions.tophat show-icons false
set_if_schema_exists org.gnome.shell.extensions.tophat show-cpu false
set_if_schema_exists org.gnome.shell.extensions.tophat show-disk false
set_if_schema_exists org.gnome.shell.extensions.tophat show-mem false
set_if_schema_exists org.gnome.shell.extensions.tophat show-fs false
set_if_schema_exists org.gnome.shell.extensions.tophat network-usage-unit bits

# Configure AlphabeticalAppGrid
set_if_schema_exists org.gnome.shell.extensions.alphabetical-app-grid folder-order-position 'end'
