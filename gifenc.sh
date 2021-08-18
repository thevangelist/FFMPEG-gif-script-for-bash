#!/bin/sh

$(ffmpeg --help 2> /dev/null > /dev/null)

if [[ $? -ne 0 ]]; then
  echo "ffmpeg is required!"
  exit 1
fi

# default values
FPS=12
RESOLUTION=850

# read the options
TEMP=`getopt -o c:r:f:t:s:d:hl:: --long resolution:,fps:,start:,to:,duration:,help,loop:: -n $0 -- "$@"`
eval set -- "$TEMP"

# extract options and their arguments into variables.
while true ; do
  case "$1" in
    -h|--help)
      echo -e "Usage: $0 [options] <input video file> <output gif name>\n"
      echo "Options:"
      echo "  -h, --help            Show this help"
      echo "  -r, --resolution      Set the pixels wide (preserving the aspect ratio)"
      echo "  -f, --fps             Set the gif frame rate"
      echo "                          default 12"
      echo "  -s, --start           Skip the first x seconds"
      echo "  -t, --to              Capture to x seconds"
      echo "  -d, --duration        Set the duration"
      echo "  -l, --loop            Number of times to loop the output"
      echo "                          default: no loop"
      echo "                          -l      output loop infinitely"
      echo "                          -l10    output loop 10 times"
      echo "Examples:"
      echo "  $0 input.mp4 out.gif"
      echo "  $0 input.mp4 out.gif -s"00:01" -d5 -r450"
      echo "  $0 input.mp4 out.gif -s"20:00" -d5 -l --fps30"
      exit;;
    -r|--resolution)
      case "$2" in
        "") shift 2 ;;
        *) RESOLUTION="$2"; shift 2 ;;
      esac ;;
    -t|--to)
      case "$2" in
        "") shift 2 ;;
        *) TO="-t $2"; shift 2 ;;
      esac ;;
    -l|--loop)
      case "$2" in
        "") LOOP="-loop=0" ; shift 2 ;;
        *) LOOP="-loop=$2" ; shift 2 ;;
      esac ;;
    -f|--fps)
      case "$2" in
        "") shift 2 ;;
        *) FPS="$2"; shift 2 ;;
      esac ;;
    -s|--start)
      case "$2" in
        "") shift 2 ;;
        *) START="-ss $2"; shift 2 ;;
      esac ;;
    -d|--duration)
      case "$2" in
        "") shift 2 ;;
        *) DURATION="-t $2"; shift 2 ;;
      esac ;;
    --) shift ; break ;;
    *) echo "Internal error!" ; exit 1 ;;
  esac
done

if [[ "$#" -ne 2  ]]; then
  echo -e "Usage: $0 [options] <input video file> <output gif name>\n"
  echo -e "Illegal number of parameters for more informations:\n $0 --help "
  exit 1
fi

palette=$(mktemp /tmp/palette_XXXX.png)

filters="fps=$FPS,scale=$RESOLUTION:-1:flags=lanczos"

# echo $filters

# http://blog.pkh.me/p/21-high-quality-gif-with-ffmpeg.html#usage

# create global color palette
ffmpeg -v warning $START $TO $DURATION -i "$1" -vf "$filters,palettegen" -y "$palette"

# create GIF
ffmpeg -v warning $START $TO $DURATION -i "$1" -i "$palette" -lavfi "$filters [x]; [x][1:v] paletteuse" -y "$2"

rm $palette
