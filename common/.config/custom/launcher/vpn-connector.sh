#!/usr/bin/env bash

# Fetch VPN connections
ALL_VPNS=$(nmcli -t -f NAME,TYPE connection | grep -i vpn | cut -d: -f1)
ACTIVE_VPNS=$(nmcli -t -f NAME,TYPE connection show --active | grep -i vpn | cut -d: -f1)

# Start JSON array
echo "["

FIRST=1
while IFS= read -r vpn; do
    [ -z "$vpn" ] && continue
    
    # Add a comma between JSON objects (but not before the first one)
    [ $FIRST -eq 0 ] && echo ","
    FIRST=0

    # Determine state and set the shell commands
    if echo "$ACTIVE_VPNS" | grep -qx "$vpn"; then
        LABEL="Disconnect: $vpn"
        EXEC="nmcli connection down '$vpn' && notify-send 'VPN Manager' 'Disconnected from $vpn'"
    else
        LABEL="Connect: $vpn"
        EXEC="nmcli connection up '$vpn' && notify-send 'VPN Manager' 'Connected to $vpn'"
    fi

    # Print the JSON object
    cat <<EOF
  {
    "label": "$LABEL",
    "sub": "VPN Manager",
    "exec": "sh -c \"$EXEC\"",
    "searchable": "$vpn"
  }
EOF
done <<< "$ALL_VPNS"

# End JSON array
echo "]"
