shopt extglob;

theme="style_2"

dir="$HOME/.config/rofi/launchers/text"
styles=($(ls -p --hide="colors.rasi" $dir/styles))
color="${styles[$(( $RANDOM % 10 ))]}"

# comment this line to disable random colors
sed -i -e "s/@import .*/@import \"$color\"/g" $dir/styles/colors.rasi

#prompt1_answer=$(echo "سیو کنم؟" | rofi -no-show-match -dmenu);
prompt1_answer=$(echo "به چه اسمی سیو کنم؟(خالی بدون سیو)" | rofi -no-show-match -dmenu -theme $dir/"$theme");
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
