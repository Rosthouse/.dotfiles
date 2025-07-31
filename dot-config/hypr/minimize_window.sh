windowName=$(hyprctl activewindow -j | jq -r ".class")


echo $windowName
case $windowName in

  Steam)
    xdotool getactivewindow windowunmap;;

  *)
    hyprctl dispatch killactive "";;
esac
