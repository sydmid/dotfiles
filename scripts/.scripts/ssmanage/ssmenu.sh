to_open=$(printf "index\nss\nbooks" | rofi -dmenu) &&
case $to_open in

  index)
    rofi -show file-browser-extended [ -file-browser-dir /home/omid/Pictures/Index ] [ -file-browser-depth 1 ] [ -file-browser-hide-parent ]
    ;;

  ss)
    rofi -show file-browser-extended [ -file-browser-dir /home/omid/Pictures/SS ] [ -file-browser-depth 1 ] [ -file-browser-hide-parent ]
    ;;

  books)
    rofi -show file-browser-extended [ -file-browser-dir /home/omid/Documents/syncthing ] [ -file-browser-depth 3 ] [ -file-browser-hide-parent ]
    ;;

  *)
    echo -n "unknown"
    ;;
esac

