#!/bin/sh

if test $# -lt 6; then 
	cat <<-EOH
	$0: Script to generate animated gifs easily from command line.
	
	Usage:
	
	$0 input.(mp4|avi|webm|flv|...) output.gif horizontal_resolution fps start_time duration
	EOH
    exit 1
fi

palette="$(mktemp /tmp/ffmpeg2gifXXXXXX.png)"

filters="fps=$4,scale=$3:-1:flags=lanczos"

ffmpeg -v warning -ss "$5" -t "$6" -i "$1" -vf "$filters,palettegen" -y "$palette"
ffmpeg -v warning -ss "$5" -t "$6" -i "$1" -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse" -y "$2"

rm -f "$palette"
