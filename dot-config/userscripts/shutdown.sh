#!/bin/bash

selected = $(exec wofi -d --location=top_right --width=600 --height=200 --xoffset=-60 "shutdown\nrestart\nlogout")

echo "$selected"

case selected in
"shutdown")
  exec shutdown now
  ;;

"restart")
  exec reboot
  ;;

"logout")
  exit
  ;;
esac
