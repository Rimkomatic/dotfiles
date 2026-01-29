#!/bin/bash

virsh --connect qemu:///system start win11
sleep 100
xfreerdp -grab-keyboard /v:192.168.122.224 /u:rikw11 /p:tine /size:100% /d: /dynamic-resolution /gfx-h264:avc444 +gfx-progressive
