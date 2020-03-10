#!/bin/bash

tempbg="/tmp/tmpbg.png"
lock_icon=${1:-$HOME/.config/i3/lock.png}

# Take screenshot
scrot "$tempbg"
# Immediately lock with the raw screenshot
i3lock --image "$tempbg" --no-unlock-indicator
# pixilize
mogrify -define jpeg:fancy-upsampling=off -scale 12.5% -scale 800% "$tempbg"
# Add overlay
convert "$tempbg" $lock_icon -gravity center -composite "$tempbg"
# Pause Spotify
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop &
# kill previous lock so we can use the proper image
killall i3lock
# Lock Screen using the now modified screenshot
i3lock --image "$tempbg" --nofork --no-unlock-indicator
# Remove temporary file
rm "$tempbg"
