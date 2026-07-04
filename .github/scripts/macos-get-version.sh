#!/bin/bash
set -eu
{
  echo 'OCTAVE_VERSION<<ENDOFVALUE'
  brew info --json octave | python3 -c "import sys,json; print(json.load(sys.stdin)[0]['versions']['stable'])"
  echo 'ENDOFVALUE'
} >> "$GITHUB_ENV"

# gcc provides libgfortran, which the cached Octave Cellar links against at a
# fixed path (e.g. /opt/homebrew/opt/gcc/lib/gcc/current/libgfortran.5.dylib).
# Key the cache on gcc's version too, so a gcc bump invalidates the cache
# instead of restoring an Octave binary that dyld can no longer resolve.
{
  echo 'GCC_VERSION<<ENDOFVALUE'
  brew info --json gcc | python3 -c "import sys,json; print(json.load(sys.stdin)[0]['versions']['stable'])"
  echo 'ENDOFVALUE'
} >> "$GITHUB_ENV"
