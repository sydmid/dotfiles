shopt extglob;

prompt1_answer=$(echo "سیو کنم؟" | rofi -no-show-match -dmenu);
process_id=$!
wait $process_id
case $prompt1_answer in

    '')
    maim -s | xclip -selection clipboard -t image/png &&
    echo "coppied to your clipboard" | xargs -I {} dunstify {};
    ;;

    *)
    the_name=~/Pictures/${prompt1_answer}_$(date '+%F_%H:%M:%S').jpeg;
    maim -s | /usr/bin/convert - -resize 100% -define jpeg:dct-method=float -quality 90 ${the_name} &&
    echo "${the_name} saved" | xargs -I {} dunstify {};
    ;;

esac
