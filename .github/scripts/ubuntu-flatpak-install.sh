#!/bin/bash
set -eu
sudo apt-get install -y flatpak dbus-x11
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install -y --noninteractive flathub org.octave.Octave
