#!/bin/bash
set -eu
find ~/apt-cache -name "*.deb" -exec sudo cp {} /var/cache/apt/archives/ \;
sudo apt-get update
