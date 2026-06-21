Name = "vpnselector"
NamePretty = "VPN Manager"
Icon = ""
Cache = false
Terminal = false
-- Executes the bash command passed via the Value field
Action = "bash -c \"%VALUE%\""

function GetEntries()
    local entries = {}
    
    -- 1. Fetch active VPNs
    local active_handle = io.popen("nmcli -t -f NAME,TYPE connection show --active | grep -i vpn | cut -d: -f1")
    local active_vpns = active_handle:read("*a") or ""
    active_handle:close()
    
    -- 2. Fetch all VPNs
    local all_handle = io.popen("nmcli -t -f NAME,TYPE connection | grep -i vpn | cut -d: -f1")
    
    for vpn in all_handle:lines() do
        if vpn ~= "" then
            -- If the vpn string exists in the active_vpns string
            if string.find(active_vpns, vpn, 1, true) then
                table.insert(entries, {
                    Text = "Disconnect: " .. vpn,
                    Subtext = "Active connection",
                    Value = "nmcli connection down '" .. vpn .. "' && notify-send 'VPN Manager' 'Disconnected from " .. vpn .. "'"
                })
            else
                table.insert(entries, {
                    Text = "Connect: " .. vpn,
                    Subtext = "Available connection",
                    Value = "nmcli connection up '" .. vpn .. "' && notify-send 'VPN Manager' 'Connected to " .. vpn .. "'"
                })
            end
        end
    end
    all_handle:close()
    
    if #entries == 0 then
        table.insert(entries, { Text = "No VPNs Found", Subtext = "Check nmcli", Value = "echo" })
    end
    
    return entries
end
