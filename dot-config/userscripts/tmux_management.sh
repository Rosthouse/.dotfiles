#!/bin/bash

# Echo usage if something isn't right.
usage() {
  cat <<EOF
Usage: $0 [-w] [-c] [-h]

A tmux helper for switching between git worktrees, checking out remote
branches as new worktrees, and creating brand-new branches as worktrees.

Options:
  -w    Open an fzf picker listing the current repo's existing worktrees
        and remote branches.

        Selecting an existing worktree switches the current tmux session
        to a window for it, creating the window if it does not exist yet.

        Selecting a remote branch first creates a new worktree as a
        sibling of the current repo, named after the last slash-separated
        segment of the branch (e.g. origin/feature/team/JIRA-5669_Foo
        becomes ../JIRA-5669_Foo), then opens a tmux window in it.

  -c    Open a tmux popup that asks for a new branch name, then create a
        new branch (from the current HEAD) and check it out into a fresh
        worktree as a sibling of the current repo.

        The directory is named after the last slash-separated segment of
        the branch (e.g. feature/team/JIRA-5669_Foo becomes
        ../JIRA-5669_Foo), and a tmux window for it is opened in the
        current session.

  -h    Show this help message and exit.

Examples:
  $0 -w     Pick a worktree or branch to work on.
  $0 -c     Create a new branch and open a worktree for it.
EOF
}

select_session(){
  sesh connect "$(
    sesh list --icons | fzf-tmux -p 80%,70% \
      --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
      --header '  ^a all ^t tmux ^g configs ^d zoxide ^x tmux kill ^f find' \
      --bind 'ctrl-j:down,ctrl-k:up' \
      --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
      --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
      --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
      --bind 'ctrl-d:change-prompt(📁  )+reload(sesh list -z --icons)' \
      --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
      --bind 'ctrl-x:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
      --preview-window 'right:55%' \
      --preview 'sesh preview {}'
    )"
}

open_worktree_window() {
  worktree_dir="$1"
  window_name="$2"
  session=$(tmux display-message -p '#S')

  if tmux has-session -t "$session:$window_name" 2>/dev/null; then
    tmux select-window -t "$session:$window_name"
  else
    tmux new-window -n "$window_name" -c "$worktree_dir"
  fi
}

selectworktree() {
  selected=$({ git worktree list| sed 's/^/ /'; git branch --remote | sed 's/^//'; } | fzf-tmux -p 80%,70%)
}

switchworktree() {
  selected=$({ git worktree list| sed 's/^/ /'; git branch --remote | sed 's/^//'; } | fzf-tmux -p 80%,70% \
    --preview-window 'right:55%' \
    --preview 'git log --graph --abbrev-commit --decorate  --first-parent {}')

  if [ -z "$selected" ]; then
    return
  fi

  repo_root="$(git rev-parse --show-toplevel)"
  identifier=$(echo "$selected" | awk '{print $2}')

  case "$selected" in
    ""*) 
      worktree_dir="$identifier"
      ;;
    ""*) 
      worktree_dir="${repo_root}/../${identifier##*/}"
      if [ ! -d "$worktree_dir" ]; then
        git worktree add "$worktree_dir" "${identifier#*/}"
      fi
      ;;
    *)
      echo "unexpected selection: $selected" >&2
      return 1
      ;;
  esac

  open_worktree_window "$worktree_dir" "${identifier##*/}"
}

deleteworktree() {
  selected=$({ git worktree list| sed 's/^/ /'; git branch --remote | sed 's/^//'; } | fzf-tmux -p 80%,70%)

  if [ -z "$selected" ]; then
    return
  fi

  repo_root="$(git rev-parse --show-toplevel)"
  identifier=$(echo "$selected" | awk '{print $2}')

  case "$selected" in
    ""*) 
      worktree_dir="$identifier"
      ;;
    ""*) 
      worktree_dir="${repo_root}/../${identifier##*/}"
      if [ ! -d "$worktree_dir" ]; then
        git worktree add "$worktree_dir" "${identifier#*/}"
      fi
      ;;
    *)
      echo "unexpected selection: $selected" >&2
      return 1
      ;;
  esac

  open_worktree_window "$worktree_dir" "${identifier##*/}"
}

createworktree() {
  repo_root=$(git rev-parse --show-toplevel)
  tmpfile=$(mktemp)

  tmux display-popup -E -w 60 -h 5 \
    "read -e -p 'Branch name: ' name && printf '%s' \"\$name\" > '$tmpfile'"

  branch=$(< "$tmpfile")
  rm -f "$tmpfile"

  if [ -z "$branch" ]; then
    return
  fi

  window_name="${branch##*/}"
  worktree_dir="${repo_root}/../${window_name}"

  if [ -d "$worktree_dir" ]; then
    echo "worktree dir already exists: $worktree_dir" >&2
    return 1
  fi

  if ! git worktree add -b "$branch" "$worktree_dir"; then
    return 1
  fi

  open_worktree_window "$worktree_dir" "$window_name"
}

if [ $# -eq 0 ]; then
  usage
  exit 0
fi

while getopts ":wcsh" o; do
    case "${o}" in
        w)
            switchworktree
            ;;
        c)
            createworktree
            ;;
        s)
            select_session
            ;;
        h)
            usage
            exit 0
            ;;
        :)
            echo "ERROR: Option -$OPTARG requires an argument" >&2
            usage >&2
            exit 2
            ;;
        \?)
            echo "ERROR: Invalid option -$OPTARG" >&2
            usage >&2
            exit 2
            ;;
    esac
done
shift $((OPTIND-1))

