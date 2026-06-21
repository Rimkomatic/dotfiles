#!/bin/bash
clear
aur_helper="$(cat ~/.config/custom/settings/aur.sh)"
figlet -f smslant "Cleanup"
echo
$aur_helper -Scc
