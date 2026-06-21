#!/usr/bin/env bash

# The session name passed from the tmux command prompt
TARGET_SESSION="$1"

# Define your directories
SESSIONS_DIR="$HOME/.project-sessions"
RESURRECT_RESTORE_SCRIPT="$HOME/.config/custom/project/helpers/scripts/restore.sh"
TARGET_FILE="$SESSIONS_DIR/${TARGET_SESSION}.txt"

# Safety check 1: Did the user type anything?
if [ -z "$TARGET_SESSION" ]; then
  tmux display-message "Error: No session name provided."
  exit 1
fi

# Safety check 2: Does the requested save file actually exist?
if [ ! -f "$TARGET_FILE" ]; then
  tmux display-message "Error: Save file '${TARGET_SESSION}.txt' not found!"
  exit 1
fi

# 1. Update the 'last' symlink to point to the requested file
ln -sf "$TARGET_FILE" "$SESSIONS_DIR/last"

# 2. Run the standard tmux-resurrect restore script
"$RESURRECT_RESTORE_SCRIPT"

# 3. Notify the user
tmux display-message "Restored session from: ${TARGET_SESSION}.txt"
