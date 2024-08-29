#!/bin/bash

# Pause Spotify
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop &

# Requires the i3lock-color fork of i3lock
i3lock \
  --ignore-empty-password \
  --blur=4 \
  --image "${1:-$HOME/.config/i3/lock.png}" \
  --centered \
  --force-clock \
  --indicator \
  --radius 255 \
  --no-modkey-text \
  --ring-width 5 \
  --{ring,inside}-color="#00000000" \
  --{ring,inside}ver-color="#00000088" \
  --{ring,inside}wrong-color="#00000088" \
  --keyhl-color "#ffffffff" \
  --bshl-color "#000000ff" \
  --{verif,wrong,time,date}-font=firacode \
  --{verif,wrong,time,date}-color="#ffffffff" \
  --{verif,wrong,time,date}outline-color="#000000ff" \
  --{verif,wrong}-size=40 \
  --{time,date}-size=20 \
  --{verif,wrong,time,date}outline-width=0.25 \
  --date-str "%a %b %d" \
  --time-align 1 \
  --date-align 2 \
  --time-pos "x+(w/2)+7:y+20" \
  --date-pos "x+(w/2)-7:y+20" \
  --pass-{media,screen,volume}-keys
