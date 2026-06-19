#!/usr/bin/env bash

# Hardcoded paths
MANAGER_SCRIPT="$HOME/.config/custom/project/manage-project.sh"
ROFI_THEME="/home/rik/.config/rofi/launchers/type-1/style-3.rasi"

# Define the base command so we don't repeat the theme path everywhere
ROFI_CMD="rofi -dmenu -i -theme $ROFI_THEME"

# Define the main menu options
OPTIONS="🚀 Load Project\n📝 New Project\n🗑️ Delete Project"

# 1. Show the main Rofi menu
CHOICE=$(echo -e "$OPTIONS" | $ROFI_CMD -p "Project Manager")

case "$CHOICE" in
    "🚀 Load Project")
        SESSIONS=$("$MANAGER_SCRIPT" list)
        
        if [ -z "$SESSIONS" ]; then
            rofi -theme "$ROFI_THEME" -e "No saved projects found."
            exit 0
        fi
        
        TARGET=$(echo "$SESSIONS" | $ROFI_CMD -p "Load")
        
        if [ -n "$TARGET" ]; then
            wezterm start --always-new-process -- bash -c "$MANAGER_SCRIPT load '$TARGET'"
        fi
        ;;
        
    "📝 New Project")
        # Passing an empty string gives a clean prompt for typing a new name
        TARGET=$(echo "" | $ROFI_CMD -p "New Name")
        
        if [ -n "$TARGET" ]; then
            wezterm start --always-new-process -- bash -c "$MANAGER_SCRIPT new '$TARGET'"
        fi
        ;;
        
    "🗑️ Delete Project")
        SESSIONS=$("$MANAGER_SCRIPT" list)
        
        if [ -z "$SESSIONS" ]; then
            rofi -theme "$ROFI_THEME" -e "No saved projects found."
            exit 0
        fi
        
        TARGET=$(echo "$SESSIONS" | $ROFI_CMD -p "Delete")
        
        if [ -n "$TARGET" ]; then
            CONFIRM=$(echo -e "Yes\nNo" | $ROFI_CMD -p "Wipe '$TARGET'?")
            
            if [ "$CONFIRM" = "Yes" ]; then
                "$MANAGER_SCRIPT" delete "$TARGET"
                rofi -theme "$ROFI_THEME" -e "Successfully deleted '$TARGET'"
            fi
        fi
        ;;
esac
