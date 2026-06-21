#!/bin/bash

DIR="$HOME/Screenshots"
mkdir -p "$DIR"
NAME="screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png"

choice="$(
  printf '%s\n' \
    "Area → Copy" \
    "Area → Save" \
    "Screen → Copy" \
    "Screen → Save" |
  rofi -dmenu \
    -theme /home/rik/.config/rofi/launchers/type-1/style-3.rasi \
    -p "Screenshot"
)"

case "$choice" in
  "Area → Copy")
    grim -g "$(slurp)" - | wl-copy
    ;;
  "Area → Save")
    grim -g "$(slurp)" "$DIR/$NAME"
    ;;
  "Screen → Copy")
    grim - | wl-copy
    ;;
  "Screen → Save")
    grim "$DIR/$NAME"
    ;;
esac
