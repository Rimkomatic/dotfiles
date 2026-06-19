#!/usr/bin/env bash

# 1. Define directories based on your tmux config
SESSIONS_DIR="$HOME/.project-sessions"
RESURRECT_SAVE_SCRIPT="$HOME/.config/custom/project/helpers/scripts/save.sh"

# Ensure the custom sessions directory exists
mkdir -p "$SESSIONS_DIR"

# Get the current tmux session name
SESSION_NAME=$(tmux display-message -p '#S' | tr -d '\n')

# Safety check: make sure we actually got a name
if [ -z "$SESSION_NAME" ]; then
  tmux display-message "Error: Could not get tmux session name."
  exit 1
fi

# 2. Save Neovim sessions across all tmux panes
# Find all panes running 'nvim', force normal mode, and trigger the save command
tmux list-panes -a \
  -F '#{session_name}:#{window_index}.#{pane_index} #{pane_current_command}' |
grep ' nvim$' |
cut -d' ' -f1 |
while read -r pane; do
  tmux send-keys -t "$pane" Escape
  tmux send-keys -t "$pane" ":TmuxSessionSave" Enter
done

# Give Neovim a moment to write the session files to disk before tmux saves the layout
sleep 1

# 3. Run the standard tmux-resurrect save script
"$RESURRECT_SAVE_SCRIPT"

# 4. Copy the newly generated 'last' save file to a file named after the session
# Using cp -L to ensure we copy the actual file if 'last' is a symlink
cp -L "$SESSIONS_DIR/last" "$SESSIONS_DIR/${SESSION_NAME}.txt"

# 5. Print a success message in the tmux status bar
tmux display-message "Tmux & Nvim session saved: ${SESSION_NAME}"
