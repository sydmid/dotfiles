to_open=$(printf "index\nss" | rofi -dmenu) &&
case $to_open in

  index)
    rofi -show file-browser-extended [ -file-browser-dir /home/omid/Pictures/Index ]
    ;;

  ss)
    rofi -show file-browser-extended [ -file-browser-dir /home/omid/Pictures/SS ]
    ;;

  *)
    echo -n "unknown"
    ;;
esac


