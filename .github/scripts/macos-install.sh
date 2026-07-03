#!/usr/bin/env bash
set -eu

BREW_CELLAR="$(brew --cellar)"
BREW_OPT="$(brew --prefix)/opt"

if [ "${CACHE_HIT:-}" == "true" ]; then
  echo "Restoring Octave Cellar from cache archive..."
  tar -xf ~/brew-octave-cellar.tar -C /
  echo "Linking octave..."
  brew link octave
else
  ls "$BREW_CELLAR" | sort > /tmp/brew_cellar_before.txt
  ls "$BREW_OPT" | sort > /tmp/brew_opt_before.txt
  echo "Installing octave..."
  brew install octave
  echo "Creating Cellar cache archive..."
  NEW_CELLAR=$(comm -13 /tmp/brew_cellar_before.txt <(ls "$BREW_CELLAR" | sort))
  NEW_OPT=$(comm -13 /tmp/brew_opt_before.txt <(ls "$BREW_OPT" | sort))
  PATHS=()
  while IFS= read -r f; do
    [ -d "$BREW_CELLAR/$f" ] && PATHS+=("$BREW_CELLAR/$f")
  done <<< "$NEW_CELLAR"
  while IFS= read -r f; do
    [ -e "$BREW_OPT/$f" ] && PATHS+=("$BREW_OPT/$f")
  done <<< "$NEW_OPT"
  tar -cf ~/brew-octave-cellar.tar "${PATHS[@]}"
  echo "Cache archive created with ${#PATHS[@]} entries"
fi

# Set Qt plugin path so octave can find the cocoa platform plugin
QT_PREFIX=$(brew --prefix qtbase 2>/dev/null || brew --prefix qt)
echo "QT_QPA_PLATFORM_PLUGIN_PATH=$QT_PREFIX/share/qt/plugins/platforms" >> "$GITHUB_ENV"
echo "Set QT_QPA_PLATFORM_PLUGIN_PATH=$QT_PREFIX/share/qt/plugins/platforms"
