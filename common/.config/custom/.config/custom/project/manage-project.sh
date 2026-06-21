#!/usr/bin/env bash

# Paths
TMUX_SESSIONS_DIR="$HOME/.project-sessions"
NVIM_SESSIONS_DIR="$HOME/.local/state/nvim/sessions"
RESURRECT_DIR="$HOME/.config/custom/project/helpers/scripts/"

# Ensure directories exist
mkdir -p "$TMUX_SESSIONS_DIR" "$NVIM_SESSIONS_DIR"

# ---------------------------------------------------------
# Core Functions
# ---------------------------------------------------------

get_sessions() {
    if [ -d "$TMUX_SESSIONS_DIR" ]; then
        # Exclude the auto-generated tmux_resurrect files from the search
        find "$TMUX_SESSIONS_DIR" -maxdepth 1 -name "*.txt" ! -name "tmux_resurrect_*.txt" -type f -exec basename {} .txt \; | sort
    fi
}

in_tmux() {
    [ -n "$TMUX" ]
}

do_list() {
    get_sessions
}

do_load() {
    local TARGET="$1"
    
    if [ -z "$TARGET" ]; then
        echo "Error: No session name provided."
        echo "Usage: $0 load <session_name>"
        return 1
    fi

    if tmux has-session -t "$TARGET" 2>/dev/null; then
        echo "Session '$TARGET' is already running. Attaching..."
        if in_tmux; then
            tmux switch-client -t "$TARGET"
        else
            tmux attach-session -t "$TARGET"
        fi
    else
        echo "Restoring session '$TARGET' from backup..."
        tmux new-session -d -s "dummy_restore" 2>/dev/null
        
        ln -sf "$TMUX_SESSIONS_DIR/${TARGET}.txt" "$TMUX_SESSIONS_DIR/last"
        
        tmux run-shell "$RESURRECT_DIR/restore.sh"
        
        sleep 1.5
        
        if tmux has-session -t "$TARGET" 2>/dev/null; then
            tmux kill-session -t "dummy_restore" 2>/dev/null
            
            if in_tmux; then
                tmux switch-client -t "$TARGET"
            else
                tmux attach-session -t "$TARGET"
            fi
        else
            echo "Error: Tmux-resurrect failed to build the session '$TARGET'."
            echo "Make sure your save file isn't empty and that @resurrect-dir is set."
        fi
    fi
}

do_save() {
    if ! in_tmux; then
        echo "Error: You must be inside a Tmux session to save it."
        return 1
    fi

    local CURRENT_SESSION
    CURRENT_SESSION=$(tmux display-message -p '#S' | tr -d '\n')
    
    local TARGET_NAME="${1:-$CURRENT_SESSION}"

    echo "Saving Neovim states..."
    tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index} #{pane_current_command}' |
    grep ' nvim$' | cut -d' ' -f1 |
    while read -r pane; do
        tmux send-keys -t "$pane" Escape
        tmux send-keys -t "$pane" ":TmuxSessionSave" Enter
    done

    sleep 1
    echo "Saving Tmux state..."
    "$RESURRECT_DIR/save.sh"
    
    # Copy the generated data to our named project file
    cp -L "$TMUX_SESSIONS_DIR/last" "$TMUX_SESSIONS_DIR/${TARGET_NAME}.txt"
    
    # Update 'last' to point to our clean file so resurrect is happy
    ln -sf "$TMUX_SESSIONS_DIR/${TARGET_NAME}.txt" "$TMUX_SESSIONS_DIR/last"
    
    # SILENT CLEANUP: Nuke all auto-generated timestamped files
    rm -f "$TMUX_SESSIONS_DIR"/tmux_resurrect_*.txt
    
    echo "Project '$TARGET_NAME' saved successfully."
}

do_create() {
    local NEW_NAME="$1"
    
    if [ -z "$NEW_NAME" ]; then
        echo "Error: No project name provided."
        echo "Usage: $0 new <session_name>"
        return 1
    fi

    if tmux has-session -t "$NEW_NAME" 2>/dev/null; then
        echo "A session with the name '$NEW_NAME' already exists."
        return 1
    fi

    if in_tmux; then
        tmux new-session -d -s "$NEW_NAME"
        tmux switch-client -t "$NEW_NAME"
    else
        tmux new-session -s "$NEW_NAME"
    fi
}

do_delete() {
    local TARGET="$1"
    
    if [ -z "$TARGET" ]; then
        echo "Error: No session name provided."
        echo "Usage: $0 delete <session_name>"
        return 1
    fi

    local TMUX_FILE="$TMUX_SESSIONS_DIR/${TARGET}.txt"
    local DELETED=0

    # 1. Delete the Tmux save file
    if [ -f "$TMUX_FILE" ]; then
        rm "$TMUX_FILE"
        echo "Deleted Tmux file: $TARGET.txt"
        DELETED=1
    fi

    # 2. Delete ALL associated Neovim states (anything starting with TARGET_)
    # We use find to strictly look for files matching the new naming scheme
    local NVIM_MATCHES
    NVIM_MATCHES=$(find "$NVIM_SESSIONS_DIR" -maxdepth 1 -name "${TARGET}_*" -type f)
    
    if [ -n "$NVIM_MATCHES" ]; then
        # Nuke all matching files silently
        echo "$NVIM_MATCHES" | xargs rm -f
        
        # Count how many Neovim panes we just cleaned up
        local COUNT
        COUNT=$(echo "$NVIM_MATCHES" | wc -l)
        echo "Deleted $COUNT associated Neovim pane state(s)."
        DELETED=1
    fi
    
    if [ $DELETED -eq 0 ]; then
        echo "No saved data found for project '$TARGET'."
    fi
}

# ---------------------------------------------------------
# Argument Routing
# ---------------------------------------------------------

COMMAND="$1"
ARG="$2"

case "$COMMAND" in
    list)
        do_list
        ;;
    load|enter)
        do_load "$ARG"
        ;;
    new|create)
        do_create "$ARG"
        ;;
    save)
        do_save "$ARG"
        ;;
    delete|rm)
        do_delete "$ARG"
        ;;
    *)
        echo "Tmux Project Manager"
        echo "Usage: $0 {list | load <name> | new <name> | save [name] | delete <name>}"
        exit 1
        ;;
esac
