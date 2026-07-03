#!/bin/bash
set -eu
sudo apt-get install -y gnuplot
sudo snap wait system seed.loaded

# Trigger the snapd snap self-update proactively so the daemon restart
# happens now rather than mid-install of octave. --no-wait returns
# immediately; we then poll until snapd is back up.
sudo snap install snapd --no-wait || true
echo "Waiting for snapd to finish restarting..."
for i in $(seq 1 120); do
  if sudo snap version >/dev/null 2>&1; then
    echo "snapd ready after ${i}x5s"
    break
  fi
  sleep 5
done

sudo snap install octave --edge
sudo snap connect octave:x11
