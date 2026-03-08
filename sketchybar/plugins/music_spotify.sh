#!/bin/bash

# Music - shows currently playing track (Spotify only)
# Displays song name with inverted scrolling behavior
# Expands with more space when playing, compact when paused

GREEN=0xffb7cc85
DIM=0xff565f89

# Check if Spotify is running using pgrep (safe, won't launch the app)
if pgrep -x "Spotify" > /dev/null 2>&1; then
  SPOTIFY_PLAYING=$(osascript -e 'tell application "Spotify" to player state' 2>/dev/null)
  if [ "$SPOTIFY_PLAYING" = "playing" ]; then
    TRACK=$(osascript -e 'tell application "Spotify" to name of current track' 2>/dev/null)
    # Display song name only with inverted scroll
    sketchybar --set $NAME icon.color=$GREEN label="♫ $TRACK"
    exit 0
  fi
fi

# Nothing playing — compact display
sketchybar --set $NAME icon.color=$DIM label="♫"
