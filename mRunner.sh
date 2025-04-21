#!/bin/bash
# mRunner.sh Created: 02/17/2025 Updated: 04/20/2025
# Robert W. Eckert - rweckert@gmail.com
#        __________
#   _____\______   \__ __  ____   ____   ___________
#  /     \|       _/  |  \/    \ /    \_/ __ \_  __ \
# |  Y Y  \    |   \  |  /   |  \   |  \  ___/|  | \/
# |__|_|  /____|_  /____/|___|  /___|  /\___  >__|
#       \/       \/           \/     \/     \/  v:1.1
# A simple run command menu tray utility.

fcall="export -f"
bcall="bash -c"
afp=$(dirname "$(realpath "$0")")
export app="$afp/mRunner.sh"
export td="/tmp"
export tf="$td/mRunner.txt"
export ti="$td/mRunner.ini"
export tt="$td/mRunner.tmp"

# Main Menu: ===========================
function mMenu {
xdpyinfo | grep dimensions | sed 's/ /\n/g' | sed '/^$/d' | sed -n '2p' > "$tf"
gsw=$(cat $tf | awk 'BEGIN {FS="x" } { print $1 }')
gsh=$(cat $tf | awk 'BEGIN {FS="x" } { print $2 }')
naw=$((gsw - 300))
nah=$((gsh - 40))
yad --form --css="$tp" --posx="$naw" --posy="$nah" --fixed --title="mRunner-Menu" --name="mMenu" --window-icon="applications-system" --f1-action="$app mHelp" --no-buttons --columns=7 \
--field "Run":fbtn "$app mRun" \
--field "Apps":fbtn "$app mApps" \
--field "List":fbtn "$app mList" \
--field "Theme":fbtn "$app mTheme" \
--field "Help":fbtn "$app mHelp" \
--field "About":fbtn "$app mAbout" \
--field="Close":fbtn "wmctrl -c 'mRunner-Menu'" 2>/dev/null
}
$fcall mMenu

# Menu Tray: ===========================
function mTray {
wmctrl -c 'mRunner-Menu'
yad --notification --css="$tp" \
--image="applications-system" \
--text="mRunner Menu" \
--menu="Run!$app mRun!gtk-execute|Apps !$app mApps!gtk-yes|List History !$app mList!gtk-index|Main Menu !$app mMenu!gtk-home|Refresh !$app tRefresh!gtk-refresh|Quit mRunner !quit!gtk-quit" \
--command="menu" 2>/dev/null
}
$fcall mTray

# Tray Refresh: ========================
function tRefresh {
ypi=`/bin/ps -fu $USER| grep "mRunner Menu" | grep -v "grep" | awk '{print $2}'`
kill -9 $ypi
mTray
}
$fcall tRefresh

# Apps Menu: ===========================
function mApps {
wmctrl -c 'mRunner-Menu'
yad --icons --css="$tp" --width=200 --height=480 --mouse --compact --read-dir="/usr/share/applications" --sort-by-name --title="mRunner-Apps" --name="mApps" --window-icon="text-x-script" --f1-action="$app mHelp" --no-buttons 2>/dev/null
}
$fcall mApps

# Run Menu: ===========================
function mRun {
wmctrl -c 'mRunner-Menu'
xdpyinfo | grep dimensions | sed 's/ /\n/g' | sed '/^$/d' | sed -n '2p' > "$tf"
gsw=$(cat $tf | awk 'BEGIN {FS="x" } { print $1 }')
gsh=$(cat $tf | awk 'BEGIN {FS="x" } { print $2 }')
naw=$((gsw - 700))
nah=$((gsh - 40))
ydo=$(yad --form --css="$tp" --posx="$naw" --posy="$nah" --width=700 --mouse --fixed --title="mRunner-Run" --name="mRun" --window-icon="applications-system" --always-print-result --separator="" --f1-action="$app mHelp" --button="Run":0 --button="List":2 --button="Cancel":1 --columns=1 --field="Run:Text" "" > $tt 2>/dev/null)
ydo=$?
if [ $ydo -eq 0 ]; then
read mr < "$tt"
echo "$mr" >> "$td/mRunnerList.txt"
eval "$mr"
fi
if [ $ydo -eq 2 ]; then
mList
fi
}
$fcall mRun

# List Menu: ===========================
function mList {
wmctrl -c 'mRunner-Menu'
sed -i '/^$/d' "$td/mRunnerList.txt"
ec='@sh -c "echo %s > $tf & $app xCommand"'
if [ ! -f "$td/mRunnerList.txt" ]; then echo -n "" > "$td/mRunnerList.txt"; fi
ydo=$(yad --list --css="$tp" --width=300 --height=500 --mouse --title="mRunner-Commands" --name="mList" --window-icon="applications-system" --sep-value="|" --item-separator="|" --dclick-action="$ec" --f1-action="$app mHelp" --button="Clear":3 --button="Edit":2 --button="Close":1 --columns=1 --column="Command" < $td/mRunnerList.txt)
ydo=$?
if [ $ydo -eq 2 ]; then
xdg-open "$td/mRunnerList.txt"
fi
if [ $ydo -eq 3 ]; then
rm -f "$td/mRunnerList.txt"
mList
fi
}
$fcall mList

# Execute Command: =====================
function xCommand {
wmctrl -c 'mRunner-Commands'
read gec < "$tf"
eval "$gec" &
}
$fcall xCommand

# Default Settings: ====================
function sDefault {
echo -n "" > "$ti"
echo "stheme:/usr/share/themes/Breeze/gtk-4.0/gtk.css" >> "$ti"
}
$fcall sDefault

# Menu Theme: ==========================
function mTheme {
gut='@sh -c "echo %2 > $tf & $app tUser"'
gst='@sh -c "echo %5 > $tf & $app tSystem"'
ydo=$(yad --form --css="$tp" --mouse --width=300 --fixed --title="mRunner-Theme" --name="mTheme" --window-icon="text-x-script" --f1-action="$app mHelp" --button="Help":3 --button="About":2 --button="Close":1 \
--field="Custom Theme"::LBL "" \
--field="Load Theme:FL" "/usr/share/themes/" \
--field="Apply Custom Theme":fbtn "$gut" \
--field="System Default"::LBL "" \
--field="Mode:CB" "Light Theme\!Dark Theme" \
--field="Apply System Theme":fbtn "$gst" \
--field="Browse Themes Folder":fbtn "$app tBrowse" 2> /dev/null)
ydo=$?
if [[ $ydo -eq 1 ]]; then wmctrl -c 'mRunner-Theme'; fi
if [[ $ydo -eq 2 ]]; then mAbout; fi
if [[ $ydo -eq 3 ]]; then mHelp; fi
}
$fcall mTheme

# User Selected Theme: =================
function tUser {
read gut < "$tf"
sed -i '/stheme:/d' "$ti"
echo "stheme:$gut" >> "$ti"
tApply
}
$fcall tUser

# System Theme: ========================
function tSystem {
read gst < "$tf"
if [ "$gst" = "Dark Theme" ]; then
sed -i '/stheme:/d' "$ti"
echo "stheme:/usr/share/themes/Breeze-Dark/gtk-4.0/gtk.css" >> "$ti"
fi
if [ "$gst" = "Light Theme" ]; then
sed -i '/stheme:/d' "$ti"
echo "stheme:/usr/share/themes/Breeze/gtk-4.0/gtk.css" >> "$ti"
fi
tApply
}
$fcall tSystem

# Apply Theme: =========================
function tApply {
stheme=$(grep "stheme" $ti | awk 'BEGIN {FS=":" } { print $2 }')
export tp="$stheme"
wmctrl -c 'mRunner-Menu'
wmctrl -c 'mRunner-Theme'
mMenu
}
$fcall tApply

# Browse Theme: ========================
function tBrowse {
xdg-open "/usr/share/themes/"
}
$fcall tBrowse

# Main Help: ===========================
function mHelp {
yad --html --browser --css="$tp" --width=900 --height=500 --center --title="mRunner-Documentation" --name="mHelp" --window-icon="applications-system" --uri="https://github.com/rweckert/mRunner/blob/0c1b810312fdddbf5ea563cb0915c3cf8f38d4df/README.md" --file-op
}
$fcall mHelp

# About ================================
function mAbout {
yad --about --css="$tp" \
--window-icon="applications-system" \
--image="applications-system" \
--authors="Robert W Eckert - rweckert@gmail.com" \
--license="GPL3" \
--comments="A simple run command menu tray utility.
Requires YAD 14.0+ (GTK+ 3.24.41)" \
--copyright="Updated 04/20/2025 by Robert W Eckert" \
--pversion="Version: 1.1" \
--pname="mRunner" \
--button="Close!gtk-close":1
}
$fcall mAbout

# Load Menu: ===========================
function mLoad {
if test -f "$ti"; then
stheme=$(grep "stheme" $ti | awk 'BEGIN {FS=":" } { print $2 }')
export tp="$stheme"
mTray
else
export tp=""
sDefault
mTray
fi
}
$fcall mLoad

# Exit and Cleanup =====================
function mExit {
wmctrl -c 'mRunner-Menu'
wmctrl -c 'mRunner-Run'
wmctrl -c 'mRunner-Apps'
wmctrl -c 'mRunner-Commands'
wmctrl -c 'mRunner-Theme'
wmctrl -c 'mRunner-Documentation'
rm -f "$tf"
rm -f "$tt"
exit
}
$fcall mExit

if [ -z "$1" ]; then mLoad; else $1; fi
