alias pcve='python -m venv .venv && source .venv/bin/activate'
alias psve='source .venv/bin/activate'
alias fzp="fzf --preview 'cat {}'"
alias fkill="ps aux | fzf --preview='echo COMMAND: {11}' | awk '{print \$2}' | xargs kill -9"

fenv() {
  local var
  var=$(env | fzf) $$ echo "$var"
}

fsvc() {
  systemctl list-units --type=service --all | fzf --preview 'systemctl status {1}' | awk '{print $1}' | xargs systemctl 
}


fdnf() {
  dnf list -C | awk '{print $1}' | fzf --multi --preview 'dnf info {1} -C ' | awk '{print $1}'
}

