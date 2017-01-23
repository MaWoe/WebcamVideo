#!/bin/bash

usage() {
  echo "Usage: $0 <URL> <imagesDir>"
  exit 1
}

writeImageList() {
  ls -tr *.jpg > $1
}

if [ -z $1 ] || [ -z $2 ]; then
  usage;
fi

URL="$1"
IMAGE_DIR=$(realpath $2)

echo
date
echo "================================"

NOW=$(date +%s)
TARGET="$IMAGE_DIR/$NOW.jpg"
LST="$IMAGE_DIR/images.list"
LST_OLD="$IMAGE_DIR/images.list.old"

echo "URL:     ${URL}"
echo "IMG_DIR: ${IMAGE_DIR}"
echo "TARGET:  ${TARGET}"
echo ""

wget -O $TARGET $URL

cd $IMAGE_DIR

if [ -f $LST_OLD ]; then
  rm $LST_OLD
fi

fdupes -dN .

if [ -f $LST ]; then
  echo "Moving old image list"
  mv $LST $LST_OLD
else
  touch $LST_OLD
fi

writeImageList $LST

if ! diff $LST $LST_OLD; then
  echo "New images were loaded"
  exit 0
else
  echo "Nothing new here ..."
  exit 1
fi
