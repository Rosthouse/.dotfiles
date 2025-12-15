# Remove lines with '#' | Remove empty lines | 
cat ~/.config/emoji/emoji-test.txt | sed '/^#/d' | sed '/^$/d' | awk '{print $5}' | xargs echo 

