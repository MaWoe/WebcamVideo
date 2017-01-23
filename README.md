# WebcamVideo
A set of Linux BASH scripts that periodically check a URL that you have configured for new images and melts them together into a video file.

## How to use

1. Periodically invoke `bin/loadNewImageAndMakeVideo.sh <url> <imagesDir> <outFile>` via crontab
2. Start a screen and run `makeVideoLoop.sh` with the necessary args

