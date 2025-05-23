#!/bin/bash

# Get the currently focused space index
SPACE_INDEX=$(yabai -m query --spaces --space | jq '.index')

# Check current space-specific config
CURRENT_GAP=$(yabai -m query --spaces --space | jq '.["has-padding"]')

# You can also track this using window_gap or padding size, if needed
# For simplicity, we’ll just try toggling by checking a current config value
# We use a heuristic: if there is no space-specific override, we assume it's on

# Check if the space has an override for window_gap
GAP=$(yabai -m config --space "$SPACE_INDEX" window_gap 2>/dev/null)

if [[ "$GAP" == "0" ]]; then
    yabai -m config --space "$SPACE_INDEX" top_padding    7
    yabai -m config --space "$SPACE_INDEX" bottom_padding 7
    yabai -m config --space "$SPACE_INDEX" left_padding   7
    yabai -m config --space "$SPACE_INDEX" right_padding  7
    yabai -m config --space "$SPACE_INDEX" window_gap     7
else
    yabai -m config --space "$SPACE_INDEX" top_padding    0
    yabai -m config --space "$SPACE_INDEX" bottom_padding 0
    yabai -m config --space "$SPACE_INDEX" left_padding   0
    yabai -m config --space "$SPACE_INDEX" right_padding  0
    yabai -m config --space "$SPACE_INDEX" window_gap     0
fi
