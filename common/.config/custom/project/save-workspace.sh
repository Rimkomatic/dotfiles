#!/usr/bin/env bash

tmux list-panes -a \
-F '#{session_name}:#{window_index}.#{pane_index} #{pane_current_command}' |
grep ' nvim$' |
cut -d' ' -f1 |
while read -r pane; do
    tmux send-keys -t "$pane" Escape
    tmux send-keys -t "$pane" ":TmuxSessionSave" Enter
done

sleep 1

~/.config/tmux/plugins/tmux-resurrect/scripts/save.sh
