#!/usr/bin/env bash
set -eu

# Homebrew's own downloads cache (restored by the calling action.yml step)
# lets `brew install` skip the network fetch for bottles it's already seen,
# while still running its normal install/relocate/codesign steps locally on
# every run. That's what actually makes a restored install behave like a
# fresh one; caching the installed Cellar directly and restoring it via tar
# skips those steps and produced intermittent crashes (see #3, #6).
brew install octave

# Set Qt plugin path so octave can find the cocoa platform plugin
QT_PREFIX=$(brew --prefix qtbase 2>/dev/null || brew --prefix qt)
echo "QT_QPA_PLATFORM_PLUGIN_PATH=$QT_PREFIX/share/qt/plugins/platforms" >> "$GITHUB_ENV"
echo "Set QT_QPA_PLATFORM_PLUGIN_PATH=$QT_PREFIX/share/qt/plugins/platforms"
