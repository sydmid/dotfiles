#currentSession=$(grep "SSSession='.*'" $HOME/.scripts/persistentStorage.sh | sed --expression "s/export SSSession='//g" | sed --expression "s/'//g") &&
#subSession=$(echo "Enter your desired sub-session name (Current session-name is: $currentSession)" | dmenu) &&
#/usr/bin/maim -m 1 -u | /usr/bin/convert - -resize 50% -define jpeg:dct-method=float -quality 80 ~/Pictures/${currentSession}_${subSession}_$(date '+%F_%H:%M:%S').jpeg &&
#echo "${currentSession}_${subSession}_$(date '+%F_%H:%M:%S').jpeg saved" | xargs -I {} dunstify {}

ls=$(eval 'ls')
Category=$(echo "omid, omid" | rofi -dmenu) &&
echo "You have chosen ${Category}"
