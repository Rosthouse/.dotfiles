#!/bin/bash

# Echo usage if something isn't right.
usage() { 
    echo "Usage: $0 [-p <80|443>] [-h <string>] [-f]" 1>&2; exit 1; 
}

switchworktree() {
  session=$(tmux display-message -p '#S')
  selected=$(git worktree list|  fzf-tmux -p 80%,70%)
  window_name="$(echo $selected | awk '{print $3}')"

  if tmux has-session -t "$session:$window_name";  then
    tmux select-window -t "$session:$window_name"
  else
    tmux new-window -n "$window_name" -c "$(echo $selected | awk '{print $1}')"
  fi
}

while getopts ":wh" o; do
    case "${o}" in
        w)
            switchworktree
            ;;
        h)
            usage
            ;;
        :)  
            echo "ERROR: Option -$OPTARG requires an argument"
            usage
            ;;
        \?)
            echo "ERROR: Invalid option -$OPTARG"
            usage
            ;;
    esac
done
shift $((OPTIND-1))

