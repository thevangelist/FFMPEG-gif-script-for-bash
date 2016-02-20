# FFMPEG gif script for bash

![Coding example](coding.gif)
![Gliding example](gliding.gif)

Script to generate animated gifs easily from command line.

Outputs palette-mapped .gifs with great colours & desired resolution from your videos.

## Installation

* Clone the repo
* Install ffmpeg (you might need to install a package manager, such as homebrew for OS X)

## Usage
* Run `./gifenc [input movie file] [generated gif's name] [horizontal resolution] [frames per second (fps)]`
* i.e.: `./gifenc input.mov output.gif 720 10` will output 720px wide 10fps .gif. (`chmod +x gifenc.sh` might be needed to run beforehand)

## Tips
* Tweak the parameters in order to get internet-shareable sizes
* Tested with most common movie formats

Special thanks to [this article](http://blog.pkh.me/p/21-high-quality-gif-with-ffmpeg.html).
