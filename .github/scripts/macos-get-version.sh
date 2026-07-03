#!/bin/bash
set -eu
{
  echo 'OCTAVE_VERSION<<ENDOFVALUE'
  brew info --json octave | python3 -c "import sys,json; print(json.load(sys.stdin)[0]['versions']['stable'])"
  echo 'ENDOFVALUE'
} >> "$GITHUB_ENV"
