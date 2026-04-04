#!/bin/bash

create=false
install=false
activate=false
name=".venv"

while getopts "can:" opt; do
    case "${opt}" in
        c) 
          create=true 
          ;;
        i)
          install=true 
          ;;
        a)
          activate=true 
          ;;
        n)
          name="$OPTARG"
          ;;
    esac
done
shift "$(($OPTIND -1))"


if $install ; then
  if [ -d $name ] ; then 
    echo "venv $name already exists, aborting"
    exit 1
  fi

  python -m venv $name && source $name/bin/activate

fi

function create_venv() {
  # Setting up systemd
  echo "Installing picamera2 libraries"
  kernel_name=$(uname -r)
  if [[ $kernel_name == *"rpi"* ]]; then
    apt install -y python3-picamera2 --no-install-recommends
  else
    echo "We are not on a raspberry pi, so we be skipping this."
  fi
}

alias pcve='python -m venv .venv && source .venv/bin/activate'
alias psve='source .venv/bin/activate'
