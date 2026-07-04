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
elif [ "${INSTALL_TYPE}" == "macos" ]; then
  # GitHub-hosted macOS runners have no interactive window server, so
  # probing the qt graphics toolkit via the Cocoa platform plugin segfaults.
  # Force Qt's offscreen platform for this headless verification only.
  export QT_QPA_PLATFORM=offscreen
fi

eval "$EXE --version"
if [ "${INSTALL_TYPE}" == "ubuntu-snap" ]; then
  eval "xvfb-run -a $EXE --no-gui --eval \"available_graphics_toolkits\""
  eval "xvfb-run -a $EXE --no-gui --eval \"graphics_toolkit('gnuplot'); graphics_toolkit\""
else
  eval "$EXE --eval \"available_graphics_toolkits\""
  eval "$EXE --eval \"graphics_toolkit\""
fi
