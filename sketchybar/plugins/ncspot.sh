DEFAULT_NAME="ncspot"

PLAYING_COLOR=0xffa6da95
PAUSED_COLOR=0xffffa217

MAIN_PLAYING_ICON=􀑃
MAIN_PAUSED_ICON=􀊈

PLAYER_PLAYING_ICON=􀊆
PLAYER_PAUSED_ICON=􀊄

NCSPOT_RUNTIME_DIR=$(ncspot info 2>/dev/null \
  | awk '/USER_RUNTIME_PATH/ { print $2 }')
NCSPOT_SOCKET="$NCSPOT_RUNTIME_DIR/ncspot.sock"

update_playpause_icon() {
  case "$PLAYER_STATE" in
    "playing"|"Playing")
      ICON=$PLAYER_PLAYING_ICON
      ;;
    *)
      ICON=$PLAYER_PAUSED_ICON
      ;;
  esac

  sketchybar --set "$DEFAULT_NAME.playpause" icon=$ICON
}

update_track() {
  if [ -S "$NCSPOT_SOCKET" ]; then
    INFO=$(printf '\n' | nc -U "$NCSPOT_SOCKET" | head -n1)

    if [[ -n "$INFO" ]]; then
      MODE=$(echo "$INFO" | jq -r '.mode | keys[0]')
      PLAYER_STATE=$MODE
      update_playpause_icon

      if [ $PLAYER_STATE = "Playing" ]; then
        TRACK="$(echo "$INFO" | jq -r '.playable.title')"
        ARTIST="$(echo "$INFO" | jq -r '.playable.artists[0]')"

        sketchybar --set $DEFAULT_NAME \
          label="${ARTIST} - ${TRACK}" \
          icon=$MAIN_PLAYING_ICON icon.color=$PLAYING_COLOR
      else
        sketchybar --set $DEFAULT_NAME \
          label="$PLAYER_STATE" \
          icon=$MAIN_PAUSED_ICON icon.color=$PAUSED_COLOR icon.font.size=11
      fi
    else
      sketchybar --set $DEFAULT_NAME \
        label="Not Playing" \
        icon=$MAIN_PAUSED_ICON icon.color=$PAUSED_COLOR icon.font.size=11
    fi
  else
    sketchybar --set "$DEFAULT_NAME" \
      label="ncspot not running" \
      icon=$MAIN_PAUSED_ICON icon.color=$PAUSED_COLOR icon.font.size=11
  fi
  sketchybar --trigger ncspot_change
}

mouse_clicked() {
  case "$NAME" in
    "$DEFAULT_NAME")
      yabai -m space --focus 5
      ;;
    "$DEFAULT_NAME.next")
      echo "next" | nc -U "$NCSPOT_SOCKET"
      ;;
    "$DEFAULT_NAME.playpause")
      echo "playpause" | nc -U "$NCSPOT_SOCKET"
      sleep 0.2
      INFO=$(printf '\n' | nc -U "$NCSPOT_SOCKET" | head -n1)
      MODE=$(echo "$INFO" | jq -r '.mode | keys[0]')
      PLAYER_STATE=$MODE
      update_playpause_icon
      ;;
    "$DEFAULT_NAME.back")
      echo "previous" | nc -U "$NCSPOT_SOCKET"
      ;;
  esac
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  *)
    if [[ "$NAME" = "$DEFAULT_NAME" ]]; then
      update_track
    fi
    ;;
esac
