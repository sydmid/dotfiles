shopt extglob;

prompt1_answer=$(echo "????" | rofi -dmenu);
process_id=$!
wait $process_id
case $prompt1_answer in

    *)
    maim -s | /usr/bin/convert - -resize 100% -define jpeg:dct-method=float -quality 90 ~/Pictures/$(date '+%F_%H:%M:%S').jpeg &&
    echo "selected screenshot saved" | xargs -I {} dunstify {};
    ;;

    no)
    maim -s | xclip -selection clipboard -t image/png &&
    echo "coppied to your clipboard" | xargs -I {} dunstify {};
    ;;
esac
