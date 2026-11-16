#!/bin/bash
set -eu
sudo apt-get install -y gnuplot
sudo snap wait system seed.loaded

# Blocking install: the snap client waits through snapd's self-restart
# and returns only after the change completes.
sudo snap install snapd
sudo snap wait system seed.loaded

sudo snap install octave --edge
sudo snap connect octave:x11
