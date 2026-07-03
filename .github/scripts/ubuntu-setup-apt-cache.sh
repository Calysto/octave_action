#!/bin/bash
set -eu
mkdir -p ~/apt-cache
{
  echo 'OS_VERSION<<ENDOFVALUE'
  . /etc/os-release && echo "$VERSION_ID"
  echo 'ENDOFVALUE'
} >> "$GITHUB_ENV"
