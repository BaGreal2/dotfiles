#!/usr/bin/env bash
# Focused window title; fallback to app name; trimmed so it doesn't crowd status.
title="$(osascript <<'APPLESCRIPT'
tell application "System Events"
  set p to first process whose frontmost is true
  try
    set t to name of window 1 of p
  on error
    set t to ""
  end try
  if t is "" then set t to name of p
end tell
return t
APPLESCRIPT
)"

# Trim to ~80 chars
title="${title:0:80}"
sketchybar --set "$NAME" label="$title"
