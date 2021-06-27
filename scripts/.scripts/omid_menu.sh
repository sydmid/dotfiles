to_open=$(printf "ss\nbooks\ntuts\ntests" | rofi -dmenu) &&
case $to_open in

  ss)
    prompt1_message=$(printf "ss\nindex" | rofi -dmenu) &&
    case $prompt1_message in

      ss)
        rofi -show file-browser-extended [ -file-browser-dir /home/omid/Pictures/SS ] [ -file-browser-depth 1 ] [ -file-browser-hide-parent ]
      ;;

      index)
        rofi -show file-browser-extended [ -file-browser-dir /home/omid/Pictures/Index ] [ -file-browser-depth 1 ] [ -file-browser-hide-parent ]
      ;;

    esac
  ;;

  tests)
    prompt1_result=$(printf "js\npy" | rofi -dmenu) &&
    case $prompt1_result in
      js )
        sesname=$(grep "SSSession='.*'" $HOME/.scripts/persistentStorage.sh | sed --expression "s/export SSSession='//g" | sed --expression "s/'//g" | xargs -I {} echo {});
        prompt2_result=$(printf "session-name: $sesname\ntmp" | rofi -dmenu) &&
        case $prompt2_result in

          '')
          file_to_create="${HOME}/Desktop/TestLab/js/$(date '+%F_%H:%M:%S')_${sesname}.js"
          touch $file_to_create &&
          subl $file_to_create
          ;;

          tmp)
          file_to_create="${HOME}/Desktop/TestLab/js/tmp/$(date '+%F_%H:%M:%S').js"
          touch $file_to_create &&
          subl $file_to_create
          ;;

          *)
          file_to_create="${HOME}/Desktop/TestLab/js/$(date '+%F_%H:%M:%S')_${sesname}_${prompt2_result}.js"
          touch $file_to_create &&
          subl $file_to_create
          ;;

        esac
      ;;
      py )
        sesname=$(grep "SSSession='.*'" $HOME/.scripts/persistentStorage.sh | sed --expression "s/export SSSession='//g" | sed --expression "s/'//g" | xargs -I {} echo {});
        prompt2_result=$(printf "session-name: $sesname\ntmp" | rofi -dmenu) &&
        case $prompt2_result in

          '')
          file_to_create="${HOME}/Desktop/TestLab/py/$(date '+%F_%H:%M:%S')_${sesname}.py"
          touch $file_to_create &&
          subl $file_to_create
          ;;

          tmp)
          file_to_create="${HOME}/Desktop/TestLab/py/tmp/$(date '+%F_%H:%M:%S').py"
          touch $file_to_create &&
          subl $file_to_create
          ;;

          *)
          file_to_create="${HOME}/Desktop/TestLab/py/$(date '+%F_%H:%M:%S')_${sesname}_${prompt2_result}.py"
          touch $file_to_create &&
          subl $file_to_create
          ;;

        esac
      ;;
    esac
  ;;

  tuts)
    prompt1_result=$(printf "documents\ndownloads" | rofi -dmenu) &&
    case $prompt1_result in
      documents)
        rofi -show file-browser-extended [ -file-browser-dir /home/omid/Documents/Tutorials ] [ -file-browser-depth 1 ] [ -file-browser-hide-parent ]
      ;;
      downloads)
        rofi -show file-browser-extended [ -file-browser-dir /home/omid/Downloads/Downloaded\ Tutorials ] [ -file-browser-depth 1 ] [ -file-browser-hide-parent ]
      ;;
    esac
  ;;

  books)
    rofi -show file-browser-extended [ -file-browser-dir /home/omid/Documents/syncthing ] [ -file-browser-depth 3 ] [ -file-browser-hide-parent ]
  ;;

  *)
    echo -n "unknown"
  ;;
esac


