#!/usr/bin/env bash

# Hardcoded paths
MANAGER_SCRIPT="$HOME/.config/custom/project/manage-project.sh"

# Define the base command for Walker (Replaces Rofi)
WALKER_CMD="walker --dmenu"

# Define the main menu options
OPTIONS="Load Project\nNew Project\nDelete Project"

# 1. Show the main Walker menu
CHOICE=$(echo -e "$OPTIONS" | $WALKER_CMD)

case "$CHOICE" in
    "Load Project")
        SESSIONS=$("$MANAGER_SCRIPT" list)
        
        if [ -z "$SESSIONS" ]; then
            # Replaces Rofi's -e flag by piping the message to Walker
            echo "No saved projects found." | $WALKER_CMD
            exit 0
        fi
        
        TARGET=$(echo "$SESSIONS" | $WALKER_CMD)
        
        if [ -n "$TARGET" ]; then
            wezterm start --always-new-process -- "$MANAGER_SCRIPT" load "$TARGET"
        fi
        ;;
        
    "New Project")
        # Passing an empty string gives a clean prompt for typing a new name.
        # CRITICAL: Type your project name and press Shift+Enter!
        TARGET=$(echo "" | $WALKER_CMD)
        
        if [ -n "$TARGET" ]; then
            wezterm start --always-new-process -- "$MANAGER_SCRIPT" new "$TARGET"
        fi
        ;;
        
    "Delete Project")
        SESSIONS=$("$MANAGER_SCRIPT" list)
        
        if [ -z "$SESSIONS" ]; then
            echo "No saved projects found." | $WALKER_CMD
            exit 0
        fi
        
        TARGET=$(echo "$SESSIONS" | $WALKER_CMD)
        
        if [ -n "$TARGET" ]; then
            CONFIRM=$(echo -e "Yes\nNo" | $WALKER_CMD)
            
            if [ "$CONFIRM" = "Yes" ]; then
                "$MANAGER_SCRIPT" delete "$TARGET"
                echo "Successfully deleted '$TARGET'" | $WALKER_CMD
            fi
        fi
        ;;
esac
