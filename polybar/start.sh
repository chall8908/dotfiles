#!/bin/bash

# Terminate already running bar instances
killall polybar

# Launch example bar
mkdir -p "$HOME/.cache/polybar/"
polybar example &>> "$HOME/.cache/polybar/example.log" & disown

echo "Bars launched..."
