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

eval "$EXE --version"
if [ "${INSTALL_TYPE}" == "ubuntu-snap" ]; then
  eval "xvfb-run -a $EXE --no-gui --eval \"available_graphics_toolkits\""
  eval "xvfb-run -a $EXE --no-gui --eval \"graphics_toolkit('gnuplot'); graphics_toolkit\""
else
  eval "$EXE --eval \"available_graphics_toolkits\""
  eval "$EXE --eval \"graphics_toolkit\""
fi
