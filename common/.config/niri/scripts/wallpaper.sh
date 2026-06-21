#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Walpapers"

command -v wofi >/dev/null || exit 1

mapfile -t FILES < <(
  find "$WALLPAPER_DIR" -type f \( \
    -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \
  \) | sort
)

[ "${#FILES[@]}" -eq 0 ] && exit 0

# Build menu with previews
for img in "${FILES[@]}"; do
  printf '%s\x00icon\x1f%s\n' "$(basename "$img")" "$img"
done |
wofi \
  --dmenu \
  --allow-images \
  --prompt Wallpaper \
  --format i \
  --width 60% \
  --height 60% |
{
  read -r index || exit 0
  [ -z "$index" ] && exit 0
  qs -c noctalia-shell ipc call wallpaper set "${FILES[$index]}" "all"
}
