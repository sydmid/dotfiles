currentSession=$(grep "SSSession='.*'" $HOME/.scripts/persistentStorage.sh | sed --expression "s/export SSSession='//g" | sed --expression "s/'//g") &&
subSession=$(printf "Enter sub-session name (Current session-name is: $currentSession)" | rofi -font "System San Francisco Display 30" -dmenu) &&
/usr/bin/maim -m 1 -u -i $(xdotool getactivewindow) | /usr/bin/convert - -resize 50% -define jpeg:dct-method=float -quality 80 ~/Pictures/${currentSession}_${subSession}_$(date '+%F_%H:%M:%S').jpeg &&
echo "${currentSession}_${subSession}_$(date '+%F_%H:%M:%S').jpeg saved" | xargs -I {} dunstify {}
