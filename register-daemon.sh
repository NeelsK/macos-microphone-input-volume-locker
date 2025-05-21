#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPT_SRC="$SCRIPT_DIR/mac-mic-control.sh"
PLIST_TEMPLATE="$SCRIPT_DIR/com.user.miclock.plist"
PLIST_TARGET="$HOME/Library/LaunchAgents/com.user.miclock.plist"

if [ ! -f "$SCRIPT_SRC" ]; then
  echo "❌ Error: mac-mic-control.sh not found at $SCRIPT_SRC"
  exit 1
fi

echo "🔧 Creating LaunchAgent plist with current script path..."
sed "s|/Users/.*/path/to/mac-mic-control.sh|$SCRIPT_SRC|g" "$PLIST_TEMPLATE" > "$PLIST_TARGET"

chmod +x "$SCRIPT_SRC"
chmod 644 "$PLIST_TARGET"

echo "♻️ Unloading existing LaunchAgent (if exists)..."
launchctl bootout gui/$(id -u) "$PLIST_TARGET" 2>/dev/null

echo "🚀 Loading LaunchAgent..."
launchctl bootstrap gui/$(id -u) "$PLIST_TARGET"

echo "✅ Done. The service is now running with script at:"
echo "   $SCRIPT_SRC"
