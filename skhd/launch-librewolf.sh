#!/bin/bash

if pgrep -x "LibreWolf" > /dev/null; then
    open -a LibreWolf
else
    librewolf --new-window
fi
