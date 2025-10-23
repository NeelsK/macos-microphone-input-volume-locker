#!/bin/bash

# Mac Microphone Volume Lock
# Maintains a constant microphone input volume level
# by checking and resetting it every 0.5 seconds

TARGET_VOLUME=5

while true; do
  CURRENT_VOLUME=$(osascript -e "input volume of (get volume settings)")
  if [ "$CURRENT_VOLUME" -ne "$TARGET_VOLUME" ]; then
    osascript -e "set volume input volume $TARGET_VOLUME"
    echo "Volume reset to $TARGET_VOLUME% at $(date)"
  fi
  sleep 3
done