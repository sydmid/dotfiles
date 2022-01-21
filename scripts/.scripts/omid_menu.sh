#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

# Available Styles
# >> Created and tested on : rofi 1.6.0-1
#
# style_1     style_2     style_3     style_4     style_5     style_6     style_7

theme="style_2"

dir="$HOME/.config/rofi/launchers/text"
styles=($(ls -p --hide="colors.rasi" $dir/styles))
color="${styles[$(( $RANDOM % 10 ))]}"

# comment this line to disable random colors
sed -i -e "s/@import .*/@import \"$color\"/g" $dir/styles/colors.rasi

# comment these lines to disable random style
#themes=($(ls -p --hide="launcher.sh" --hide="styles" $dir))
#theme="${themes[$(( $RANDOM % 7 ))]}"

#rofi -no-lazy-grab -dmenu \
#-theme $dir/"$theme"



main_prompt=$(printf "ss\nbooks\ntuts\ntests\ngists\nprojects\ncheats" | rofi -dmenu -theme $dir/"$theme") &&
case $main_prompt in

  ss)
    prompt1=$(printf "ss\nindex\nlatest" | rofi -dmenu -theme $dir/"$theme") &&
    case $prompt1 in

      ss)
        rofi -show file-browser-extended [ -file-browser-dir /home/omid/Pictures/SS ] [ -file-browser-depth 1 ] [ -file-browser-hide-parent ]
      ;;

      index)
        rofi -show file-browser-extended [ -file-browser-dir /home/omid/Pictures/SS/_Index ] [ -file-browser-depth 1 ] [ -file-browser-hide-parent ]
      ;;

      latest)
        prompt2=$(printf "to be implemented" | rofi -dmenu -theme $dir/"$theme");
      ;;

    esac
  ;;

  tests)
    prompt1=$(printf "js\npy" | rofi -dmenu -theme $dir/"$theme") &&
    case $prompt1 in
      js )
        sesname=$(grep "SSSession='.*'" $HOME/.scripts/persistentStorage.sh | sed --expression "s/export SSSession='//g" | sed --expression "s/'//g" | xargs -I {} echo {});
        prompt2=$(printf "session-name:$sesname\ntmp" | rofi -dmenu -theme $dir/"$theme") &&
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
        prompt2=$(printf "session-name:$sesname\ntmp" | rofi -dmenu -theme $dir/"$theme") &&
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
    prompt1=$(printf "documents\ndownloads" | rofi -dmenu -theme $dir/"$theme") &&
    case $prompt1 in
      documents)
        rofi -show file-browser-extended [ -file-browser-dir /home/omid/Documents/Tutorials ] [ -file-browser-depth 1 ] [ -file-browser-hide-parent ]
      ;;
      downloads)
        rofi -show file-browser-extended [ -file-browser-dir /home/omid/Downloads/DownTuts ] [ -file-browser-depth 1 ] [ -file-browser-hide-parent ]
      ;;
    esac
  ;;

  books)
    rofi -show file-browser-extended [ -file-browser-dir /home/omid/Documents/syncthing ] [ -file-browser-depth 3 ] [ -file-browser-hide-parent ]
  ;;

  gists)
    prompt1=$(printf "js\npy" | rofi -dmenu -theme $dir/"$theme") &&
    case $prompt1 in
      js)
        prompt2=$(printf "Type your desired name" | rofi -dmenu -theme $dir/"$theme") &&
        file_to_create="${HOME}/Desktop/gists/js/${prompt2}_$(date '+%F_%H:%M:%S').js"
        touch $file_to_create &&
        code $file_to_create
      ;;
      py)
        prompt2=$(printf "Type your desired name" | rofi -dmenu -theme $dir/"$theme") &&
        file_to_create="${HOME}/Desktop/gists/py/${prompt2}_$(date '+%F_%H:%M:%S').py"
        touch $file_to_create &&
        code $file_to_create
      ;;
    esac
  ;;

  projects)
    rofi -show file-browser-extended [ -file-browser-dir /home/omid/Documents/Projects ] [ -file-browser-depth 1 ] [ -file-browser-hide-parent ]
  ;;

  cheats)
    rofi -show file-browser-extended [ -file-browser-dir /home/omid/Documents/CheatSheets ] [ -file-browser-depth 1 ] [ -file-browser-hide-parent ]
  ;;

  *)
    prompt1=$(printf "input is not right try again" | rofi -dmenu -theme $dir/"$theme");
  ;;
esac


