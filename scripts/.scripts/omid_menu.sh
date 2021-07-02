main_prompt=$(printf "ss\nbooks\ntuts\ntests\ngists\nprojects" | rofi -dmenu) &&
case $main_prompt in

  ss)
    prompt1=$(printf "ss\nindex\nlatest" | rofi -dmenu) &&
    case $prompt1 in

      ss)
        rofi -show file-browser-extended [ -file-browser-dir /home/omid/Pictures/SS ] [ -file-browser-depth 1 ] [ -file-browser-hide-parent ]
      ;;

      index)
        rofi -show file-browser-extended [ -file-browser-dir /home/omid/Pictures/SS/_Index ] [ -file-browser-depth 1 ] [ -file-browser-hide-parent ]
      ;;

      latest)
        prompt2=$(printf "to be implemented" | rofi -dmenu);
      ;;

    esac
  ;;

  tests)
    prompt1=$(printf "js\npy" | rofi -dmenu) &&
    case $prompt1 in
      js )
        sesname=$(grep "SSSession='.*'" $HOME/.scripts/persistentStorage.sh | sed --expression "s/export SSSession='//g" | sed --expression "s/'//g" | xargs -I {} echo {});
        prompt2=$(printf "session-name:$sesname\ntmp" | rofi -dmenu) &&
        case $prompt2 in

          '')
          file_to_create="${HOME}/Desktop/tests/js/$(date '+%F_%H:%M:%S')_${sesname}.js"
          touch $file_to_create &&
          code $file_to_create
          ;;

          tmp)
          file_to_create="${HOME}/Desktop/tests/js/tmp/$(date '+%F_%H:%M:%S').js"
          code $file_to_create
          ;;

          *)
          file_to_create="${HOME}/Desktop/tests/js/$(date '+%F_%H:%M:%S')_${sesname}_${prompt2}.js"
          touch $file_to_create &&
          code $file_to_create
          ;;

        esac
      ;;
      py )
        sesname=$(grep "SSSession='.*'" $HOME/.scripts/persistentStorage.sh | sed --expression "s/export SSSession='//g" | sed --expression "s/'//g" | xargs -I {} echo {});
        prompt2=$(printf "session-name:$sesname\ntmp" | rofi -dmenu) &&
        case $prompt2 in

          '')
          file_to_create="${HOME}/Desktop/tests/py/$(date '+%F_%H:%M:%S')_${sesname}.py"
          touch $file_to_create &&
          code $file_to_create
          ;;

          tmp)
          file_to_create="${HOME}/Desktop/tests/py/tmp/$(date '+%F_%H:%M:%S').ipynb"
          code $file_to_create
          ;;

          *)
          file_to_create="${HOME}/Desktop/tests/py/$(date '+%F_%H:%M:%S')_${sesname}_${prompt2}.py"
          touch $file_to_create &&
          code $file_to_create
          ;;

        esac
      ;;
    esac
  ;;

  tuts)
    prompt1=$(printf "documents\ndownloads" | rofi -dmenu) &&
    case $prompt1 in
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

  gists)
    prompt1=$(printf "js\npy" | rofi -dmenu) &&
    case $prompt1 in
      js)
        prompt2=$(printf "Type your desired name" | rofi -dmenu) &&
        file_to_create="${HOME}/Desktop/gists/js/${prompt2}_$(date '+%F_%H:%M:%S').js"
        touch $file_to_create &&
        code $file_to_create
      ;;
      py)
        prompt2=$(printf "Type your desired name" | rofi -dmenu) &&
        file_to_create="${HOME}/Desktop/gists/py/${prompt2}_$(date '+%F_%H:%M:%S').py"
        touch $file_to_create &&
        code $file_to_create
      ;;
    esac
  ;;

  projects)
    rofi -show file-browser-extended [ -file-browser-dir /home/omid/Documents/Projects ] [ -file-browser-depth 1 ] [ -file-browser-hide-parent ]
  ;;

  *)
    prompt1=$(printf "input is not right try again" | rofi -dmenu);
  ;;
esac


