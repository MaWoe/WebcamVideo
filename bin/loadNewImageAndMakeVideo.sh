#!/bin/bash

usage() {
  echo
  echo "Usage: <url> <imagesDir> <outFile>"
  echo
  exit 1
}

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ]; then
  usage
fi

URL="$1"
IMG=$2
OUT=$3

BIN=$(realpath $(dirname $0))

if $BIN/getNewestImage.sh $URL $IMG; then
  date > $IMG/newImages.txt
fi
