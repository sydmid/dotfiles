 #!/bin/sh
for I in {1..30..1}; do sleep 1 && setxkbmap -option caps:ctrl_modifier && xmodmap -e "keycode 169 = Print"; done
