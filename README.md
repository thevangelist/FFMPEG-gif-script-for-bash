# FFMPEG gif script for bash

Script to generate animated gifs easily from command line.

Outputs palette-mapped .gifs with great colours & desired resolution from your videos.

## Installation

* Clone the repo
* Install ffmpeg (you might need to install a package manager, such as brew for OS X).
* Usage: `./gifenc [input] [output] [horizontal resolution for output] [fps]`
* i.e.: `./gifenc input.mov output.gif 720 10` will output 720px wide 10fps .gif. (`chmod +x gifenc.sh` might be needed to run beforehand)

## Example

![Coding example](coding.gif)

Special thanks to [this article](http://blog.pkh.me/p/21-high-quality-gif-with-ffmpeg.html).
