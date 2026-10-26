#!/usr/bin/env bash
# Toggle pritunl VPN profiles from an fzf tmux popup.
# Enter: start/stop selected profile. Esc: quit.

list() {
  pritunl-client list --json | jq -r '.[] |
    [.id, (if .run_state == "Inactive" then "○" else "●" end), .run_state, .name] | @tsv' |
    column -t -s $'\t'
}

start_profile() {
  local out url
  out=$(pritunl-client start "$1" 2>&1)
  url=$(grep -Eo 'https?://[^[:space:]]+' <<<"$out" | head -n1)
  if [ -n "$url" ]; then
    xdg-open "$url" >/dev/null 2>&1 &
    notify-send "VPN" "SSO required, opened browser" 2>/dev/null
  fi
}

while true; do
  selected=$(list | fzf-tmux -p 90%,50% --no-sort --border-label ' vpn ' \
    --with-nth 2.. --header '● active  ○ inactive | enter: toggle') || exit 0
  [ -z "$selected" ] && exit 0
  read -r id marker _ <<<"$selected"
  if [ "$marker" = "●" ]; then
    pritunl-client stop "$id" >/dev/null 2>&1
  else
    start_profile "$id"
  fi
  sleep 1
done
