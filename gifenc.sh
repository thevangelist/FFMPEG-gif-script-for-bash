#!/bin/sh
#
# Usage: ./gifenc [input] [output] [horizontal resolution for output] [fps]
# "./gifenc input.mov output.gif 720 10" will output 720p wide 10fps gif from the mov

palette="/tmp/palette.png"

filters="fps=$4,scale=$3:-1:flags=lanczos"

ffmpeg -v warning -i $1 -vf "$filters,palettegen" -y $palette
ffmpeg -v warning -i $1 -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse" -y $2