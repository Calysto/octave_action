#!/bin/bash
set -eu
sudo apt-get autoclean
sudo find /var/cache/apt/archives -name "*.deb" -exec cp {} ~/apt-cache/ \;
sudo rm -f /var/cache/apt/archives/lock
sudo rm -rf /var/cache/apt/archives/partial
