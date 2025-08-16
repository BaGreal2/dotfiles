#!/usr/bin/env bash
FG=0xffc8c8c8
SEL_BG=0xff1b4e59
SEL_FG=0xffececec
BAR_H=32

sid="${NAME##*.}"  # from "space.N"

has_windows() {
  out="$(yabai -m query --windows --space "$sid" 2>/dev/null)"
  [ "$out" != "[]" ]
}

if has_windows || [ "$SELECTED" = "1" ] || [ "$SELECTED" = "true" ]; then
  if [ "$SELECTED" = "1" ] || [ "$SELECTED" = "true" ]; then
    sketchybar --set "$NAME" drawing=on \
      background.drawing=on background.color=$SEL_BG background.height=$BAR_H background.corner_radius=0 \
      label.color=$SEL_FG
  else
    sketchybar --set "$NAME" drawing=on background.drawing=off label.color=$FG
  fi
else
  sketchybar --set "$NAME" drawing=off
fi
