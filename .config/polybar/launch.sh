if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m killall -q polybar;
    while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
    polybar omid &
  done
else
  polybar --reload omid &
fi
