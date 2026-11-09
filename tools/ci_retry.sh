#!/usr/bin/env bash
# Runs a CI command, retrying only when a download failed with a server
# error (5xx). Real build and test failures still fail on the first attempt.
set -uo pipefail

network_error='Unexpected response code: 5[0-9][0-9]|Server returned HTTP response code: 5[0-9][0-9]|Gateway Time-out|Failed to download .*\(5[0-9][0-9]\)|returned error: 5[0-9][0-9]'
attempts="${CI_RETRY_ATTEMPTS:-3}"
delay="${CI_RETRY_DELAY:-60}"
log="$(mktemp)"
trap 'rm -f "$log"' EXIT

for ((attempt = 1; ; attempt++)); do
  "$@" 2>&1 | tee "$log"
  status="${PIPESTATUS[0]}"
  [ "$status" -eq 0 ] && exit 0
  if ! grep -Eq "$network_error" "$log" || [ "$attempt" -ge "$attempts" ]; then
    exit "$status"
  fi
  echo "::warning::Download failed with a server error (attempt $attempt of $attempts). Retrying in ${delay}s."
  sleep "$delay"
done
