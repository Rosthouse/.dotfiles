cat ~/.config/emoji/emojis.txt | fuzzel -p "Emoji" -d -i | cut -d ' ' -f 1 | tr -d '\n' | wl-copy
