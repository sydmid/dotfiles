subSession=$(echo "Enter your desired sub-session name" | dmenu) &&
/usr/bin/maim -m 1 -u | /usr/bin/convert - -resize 50% -define jpeg:dct-method=float -quality 80 ~/Pictures/${subSession}_$(date '+%F_%H:%M:%S').jpeg &&
echo "${subSession}_$(date '+%F_%H:%M:%S').jpeg saved" | xargs -I {} dunstify {}
