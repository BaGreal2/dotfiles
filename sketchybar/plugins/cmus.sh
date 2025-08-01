#!/usr/bin/env bash
DEFAULT_NAME="cmus"

export PATH="$HOME/tmp/cmus/usr/local/bin:$PATH"

TITLE=$(cmus-remote -C "format_print '%a - %t'")
FILE=$(cmus-remote -C "format_print '%f'" | sed 's!.*/!!; s!\..*!!')
STATUS=$(cmus-remote -C status | awk '/status/{print $2}')

case "$STATUS" in
  paused)  ICON='􀊆' ;;
  playing) ICON='􀑃' ;;
  *)       ICON='􀊈' ;;
esac

LABEL="${TITLE:-$FILE}"
if [[ -z "$LABEL" ]]; then
  sketchybar --set "$NAME" icon.drawing=off label.drawing=off
  exit 0
fi

sketchybar --set "$NAME" label="$LABEL" icon=$ICON icon.font="SF Pro:Regular:14.0"\
           --set "$NAME" icon.drawing=on label.drawing=on
