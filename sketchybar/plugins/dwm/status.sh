#!/opt/homebrew/bin/bash
set -euo pipefail

# ---- weather (Poznań) ----
LAT=52.4064; LON=16.9252
WX_URL="https://api.open-meteo.com/v1/forecast?latitude=$LAT&longitude=$LON&current=temperature_2m,weather_code&timezone=auto"
WX_CACHE="/tmp/skb_wx.json"; WX_TTL=600

abbr_for_code() {
  case "$1" in
    0) echo CLR ;; 1|2) echo PCL ;; 3) echo OVC ;;
    45|48) echo FOG ;; 51|53|55) echo DRZ ;;
    61|63|65|80|81|82) echo RN ;;
    71|73|75|77|85|86) echo SNW ;;
    95|96|99) echo TSTM ;; *) echo "??" ;;
  esac
}

weather() {
  local now temp code
  now=$(date +%s)
  if [[ ! -s "$WX_CACHE" || $(( now - $(stat -f %m "$WX_CACHE" 2>/dev/null || echo 0) )) -ge $WX_TTL ]]; then
    curl -fsS "$WX_URL" -o "$WX_CACHE" || true
  fi
  if command -v jq >/dev/null 2>&1; then
    temp=$(jq -r '.current.temperature_2m // empty' "$WX_CACHE" 2>/dev/null || echo "")
    code=$(jq -r '.current.weather_code // empty' "$WX_CACHE" 2>/dev/null || echo "")
  else
    temp=""; code=""
  fi
  if [[ -n "$temp" && -n "$code" ]]; then
    printf "%s %s°C" "$(abbr_for_code "$code")" "$(printf '%.0f' "$temp")"
  else
    printf "Poznan"
  fi
}

# ---- tiny bar graph ----
bars() { # $1=0..100, $2=slots
  local val slots filled i out=""
  val=${1:-0}; slots=${2:-5}
  (( val < 0 )) && val=0; (( val > 100 )) && val=100
  filled=$(( (val*slots + 50) / 100 ))
  for ((i=0; i<slots; i++)); do
    if (( i < filled )); then out+="█"; else out+="░"; fi
  done
  printf "%s" "$out"
}

# ---- CPU ----
cpu_pct() {
  local idle
  idle=$(top -l 1 -n 0 | awk '/CPU usage/ { sub("%","",$(NF-1)); print $(NF-1) }')
  printf "%d" "$(awk -v i="$idle" 'BEGIN{printf("%.0f",100-i)}')"
}

# ---- RAM: used ≈ active + wired + compressed (close to btop) ----
mem_stats() {
  local ps act wired comp total used pct
  ps=$(vm_stat | awk '/page size of/ {print $8}')
  act=$(vm_stat | awk '/Pages active/ {gsub("[^0-9]","",$3); print $3}')
  wired=$(vm_stat | awk '/Pages wired down/ {gsub("[^0-9]","",$4); print $4}')
  comp=$(vm_stat | awk '/Pages occupied by compressor/ {gsub("[^0-9]","",$5); print $5}')
  total=$(sysctl -n hw.memsize)
  used=$(( (act + wired + comp) * ps ))
  pct=$(( (used * 100) / total ))
  printf "%d %.1f\n" "$pct" "$(awk -v u="$used" 'BEGIN{printf("%.1f", u/1073741824)}')"
}

# ---- Battery (+/-NN) — exact state check, no substring clash ----
battery() {
  local line pct lower sign=""
  line=$(pmset -g batt | sed -n '2p' | tr -d '\r')
  pct=$(printf '%s\n' "$line" | grep -Eo '[0-9]{1,3}%' | head -n1 | tr -d '%')
  lower=$(printf '%s' "$line" | tr '[:upper:]' '[:lower:]')

  if [[ "$lower" == *"discharging"* ]]; then
    sign=""
  elif [[ "$lower" == *"charging"* ]]; then
    sign="+"
  else
    sign=""
  fi
  printf "%s%s" "$sign" "${pct:-0}"
}

# ---- Wi-Fi tag — use wdutil if available; fallback to networksetup/ipconfig ----
wifi_tag() {
  local wd="/System/Library/PrivateFrameworks/WirelessDiagnostics.framework/Versions/Current/usr/bin/wdutil"
  local dev power ssid=""

  # 1) Newer macOS: wdutil
  if [[ -x "$wd" ]]; then
    ssid=$("$wd" info 2>/dev/null | awk -F': *' '/^SSID/ {print $2; exit}')
  fi

  # 2) Fallback: networksetup (device + power + association)
  if [[ -z "$ssid" ]]; then
    dev=$(networksetup -listallhardwareports | awk '/Wi-Fi|AirPort/{getline; print $2; exit}')
    [[ -z "${dev:-}" ]] && dev="Wi-Fi"
    power=$(networksetup -getairportpower "$dev" 2>/dev/null | awk '{print $NF}')
    if [[ "$power" == "On" ]]; then
      out=$(networksetup -getairportnetwork "$dev" 2>/dev/null || true)
      if printf '%s' "$out" | grep -q "^Current Wi-Fi Network:"; then
        ssid=$(printf '%s' "$out" | sed -n 's/^Current Wi-Fi Network:[[:space:]]*//p')
      fi
      # 3) Last resort: has an IP on that iface → treat as associated
      [[ -z "$ssid" ]] && ipconfig getifaddr "$dev" >/dev/null 2>&1 && ssid="*"
    fi
  fi

  [[ -n "$ssid" ]] && echo "[WiFi]" || echo "[Off]"
}

# ---- assemble ----
wx="$(weather)"
c_pct="$(cpu_pct)"
read -r m_pct m_used_g <<<"$(mem_stats)"

label="$wx  CPU: [$(bars "$c_pct" 5)] ${c_pct}%  RAM: [$(bars "$m_pct" 5)] ${m_used_g}G  B: $(battery)%  $(wifi_tag)  $(date '+%b %d %H:%M')"

if [[ -n "${NAME:-}" ]]; then
  sketchybar --set "$NAME" label="$label"
else
  printf "%s\n" "$label"
fi
