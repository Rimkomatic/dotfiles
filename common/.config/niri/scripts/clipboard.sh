#!/bin/bash
sleep 1
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &
wait
