#!/usr/bin/bash
alias cat=bat
alias cd=z
alias dn='dotnet'
alias fzp="fzf --preview 'cat {}'"
alias ls='ls -l'
alias oc=opencode
alias prtl=pritunl-client
alias rs='source ~/.bashrc'
alias ts=tree-sitter
alias sld='stow -R --dotfiles -v -t ~ .'

nsl() {
  qs -c noctalia-shell ipc call "$@"
}

fps() {
  ps aux | fzf --preview='echo COMMAND: {11}' | awk '{print $2}' 
}

fkill() {
  ps aux | fzf --preview='echo COMMAND: {11}' | awk '{print $2}' | xargs kill -9 
}

fsvc() {
  systemctl list-units --type=service --all | fzf --preview 'systemctl status {1}' | awk '{print $1}' | xargs systemctl 
}

fdnf() {
  dnf list -C | awk '{print $1}' | fzf --multi --preview 'dnf info {1} -C ' | awk '{print $1}'
}

zd() {
  zoxide "$@"
}

sc() {
  sesh connect "$(sesh list | fzf)"
}
