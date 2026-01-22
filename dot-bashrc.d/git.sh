#!/bin/bash
alias gitb="git branch --no-color | fzf -m | xargs -I {} git branch -D '{}'"
