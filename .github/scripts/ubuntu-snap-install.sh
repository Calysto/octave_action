#!/bin/bash
set -eu
sudo apt-get install -y gnuplot
sudo snap wait system seed.loaded

# Refresh snapd now so its self-restart doesn't happen mid-install of octave.
change=$(sudo snap install snapd --no-wait 2>/dev/null || true)
if [ -n "$change" ]; then
  echo "Waiting for snapd refresh (change $change)..."
  # snap watch can error while the daemon restarts; retry until the change is done.
  for i in $(seq 1 60); do
    if sudo snap watch "$change" >/dev/null 2>&1; then break; fi
    sleep 5
  done
fi
# Make sure the daemon itself answers (snap version alone doesn't check this).
for i in $(seq 1 60); do
  sudo snap changes >/dev/null 2>&1 && break
  sleep 5
done

# Retry in case snapd still has a transient error.
for i in 1 2 3 4 5; do
  if sudo snap install octave --edge; then break; fi
  [ "$i" = 5 ] && exit 1
  echo "snap install failed, retrying in 10s..."; sleep 10
done
sudo snap connect octave:x11
