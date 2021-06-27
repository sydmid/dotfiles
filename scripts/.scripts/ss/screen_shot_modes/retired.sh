currentSession=$(grep "SSSession='.*'" $HOME/.scripts/persistentStorage.sh | sed --expression "s/export SSSession='//g" | sed --expression "s/'//g") &&
/usr/bin/maim -m 1 -u -i $(xdotool getactivewindow) | /usr/bin/convert - -resize 50% -define jpeg:dct-method=float -quality 80 ~/Pictures/${currentSession}_$(date '+%F_%H:%M:%S').jpeg &&
echo "${currentSession}_$(date '+%F_%H:%M:%S').jpeg saved" | xargs -I {} dunstify {}
