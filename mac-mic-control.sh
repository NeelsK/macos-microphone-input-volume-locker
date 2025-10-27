#!/bin/bash

# Mac Microphone Volume Lock
# Maintains a constant microphone input volume level
# by checking and resetting it every 0.5 seconds

TARGET_VOLUME=1

while true; do
  CURRENT_OUTPUT=$(SwitchAudioSource -t output -c)
  CURRENT_INPUT=$(SwitchAudioSource -t input -c)
  if [[ "$CURRENT_OUTPUT" == "APM" ]]; then
    if [[ "$CURRENT_INPUT" != "MacBook Pro Microphone" ]]; then
      switchaudiosource -t input -s "MacBook Pro Microphone"
    fi
    CURRENT_VOLUME=$(osascript -e "input volume of (get volume settings)")
    if [ "$CURRENT_VOLUME" -ne "$TARGET_VOLUME" ]; then
      osascript -e "set volume input volume $TARGET_VOLUME"
      echo "Volume reset to $TARGET_VOLUME% at $(date)"
    fi
    sleep 3
  fi
done