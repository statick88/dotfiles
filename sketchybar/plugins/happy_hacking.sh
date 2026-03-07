#!/bin/bash

# Happy Hacking - static reminder message
sketchybar --set "$NAME" \
  icon="HH" \
  icon.font="IosevkaTerm NF:Bold:10.0" \
  icon.color="$MAGENTA" \
  label="Happy Hacking" \
  label.font="IosevkaTerm NF:Medium:10.0" \
  label.color="$WHITE" \
  background.color="$ISLAND_BG" \
  background.border_color="$ISLAND_BORDER" \
  background.border_width=1 \
  background.corner_radius=4 \
  background.height=24 \
  update_freq=60 \
  click_script="sketchybar --trigger happy_hacking_ack"
