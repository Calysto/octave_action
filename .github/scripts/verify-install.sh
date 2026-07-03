#!/bin/bash
set -eu

EXE="octave"
if [ "${INSTALL_TYPE}" == "ubuntu-flatpak" ]; then
  EXE="flatpak run org.octave.Octave"
elif [ "${INSTALL_TYPE}" == "ubuntu-snap" ]; then
  EXE="octave.octave-cli"
fi

if [[ "${INSTALL_TYPE}" == ubuntu* ]]; then
  Xvfb :99 -screen 0 1024x768x24 &
  export DISPLAY=:99
fi

$EXE --version
if [ "${INSTALL_TYPE}" == "ubuntu-snap" ]; then
  xvfb-run -a $EXE --no-gui --eval "available_graphics_toolkits"
  xvfb-run -a $EXE --no-gui --eval "graphics_toolkit('gnuplot'); graphics_toolkit"
else
  $EXE --eval "available_graphics_toolkits"
  $EXE --eval "graphics_toolkit"
fi
