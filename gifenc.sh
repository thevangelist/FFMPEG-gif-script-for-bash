#!/bin/sh

if test $# -lt 4; then 
	cat <<-EOH
	$0: Script to generate animated gifs easily from command line.
	
	Usage:
	
	$0 input.(mp4|avi|webm|flv|...) output.gif horizontal_resolution fps
	EOH
    exit 1
fi

filters="fps=$4,scale=$3:-1:flags=lanczos"
ffmpeg -v warning -i "$1" -filter_complex "[0:v] ${filters}, split [1:v] [2:v]; [1:v] palettegen [p]; [2:v] fifo [3:v]; [3:v] [p] paletteuse" -y "$2"
