# FFMPEG gif script for bash

Outputs palette-mapped .gifs with great colours & desired resolution from your videos.

* Install ffmpeg (you might need to install a package manager, such as brew for OS X).
* Clone the repo
* Usage: `./gifenc [input] [output] [horizontal resolution for output] [fps]`
* i. e.: `./gifenc input.mov output.gif 720 10` will output 720px wide 10fps .gif. (`chmod +x gifenc.sh` might be needed to run beforehand)

Thanks to [this article](http://blog.pkh.me/p/21-high-quality-gif-with-ffmpeg.html).
