#!/bin/bash

usage() {
  echo
  echo "Checks for the \"newImages.txt\" token in given sub dirs"
  echo "and starts creating video files in the specified out dir."
  echo
  echo "Usage: $0 <imageBaseDir> \"<space separated list of sub dirs>\" <out dir>"
  echo
  echo "Example: $0 /var/www/WebcamVideo/images \"cam1 cam2 cam3\""
  echo
}

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ]; then
  usage
  exit 1
fi

BIN=$(dirname $0)
BASE=$(realpath "$BIN/..")
IMG_BASE=$1
SUB_DIRS="$2"
OUT_BASE=$3

echo
echo "IMG_BASE: $IMG_BASE"
echo "WEB:      $WEB"
echo

while true; do
echo
date
echo "----------------"
echo "Start scanning"

for i in $SUB_DIRS;do

  IMG="$IMG_BASE/$i"
  OUT="$OUT_BASE/$i.mp4"

  echo
  echo "IMG: $IMG"
  echo "OUT: $OUT"
  echo

  if [ -f $IMG/newImages.txt ]; then
    echo "New images. Start building"
    $BIN/makeSmoothVideo.sh $IMG 2 5 $OUT
    rm $IMG/newImages.txt
  else
    echo "Nothing new here"
  fi

done

echo
echo "Sleeping ..."
sleep 5

done
