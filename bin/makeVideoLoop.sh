#!/bin/bash

BIN=$(dirname $0)
BASE=$(realpath "$BIN/..")
IMG_BASE="$BASE/images"
WEB="$BASE/web";

echo
echo "IMG_BASE: $IMG_BASE"
echo "WEB:      $WEB"
echo

while true; do
echo
date
echo "----------------"
echo "Start scanning"

for i in holz halde schau;do

  IMG="$IMG_BASE/$i"
  OUT="$WEB/$i.mp4"

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

echo "Sleeping ..."
sleep 5

done
