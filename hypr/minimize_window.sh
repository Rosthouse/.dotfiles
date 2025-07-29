windowName=$(hyprctl activewindow -j | jq -r ".class")


echo $windowName
case $windowName in

  Steam | Spotify)
    xdotool getactivewindow windowunmap;;

  *)
    hyprctl dispatch killactive "";;
esac
