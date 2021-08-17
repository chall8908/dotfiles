#!/bin/bash

# Terminate already running bar instances
killall polybar

# Launch example bar
polybar example &>> /var/log/polybar/example.log & disown

echo "Bars launched..."
