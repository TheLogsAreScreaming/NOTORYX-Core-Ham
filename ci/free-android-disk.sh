#!/usr/bin/env bash
set -euo pipefail
# These are unused tools on disposable GitHub-hosted Android runners.
# Keep the Android SDK/NDK, Java, Flutter, repository and Gradle caches.
df -h .
sudo rm -rf /usr/share/dotnet /opt/ghc /usr/local/share/boost /usr/local/share/powershell /opt/hostedtoolcache/CodeQL
if command -v docker >/dev/null 2>&1; then
  docker image prune --all --force
fi
df -h .
