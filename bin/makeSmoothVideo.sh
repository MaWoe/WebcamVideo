#!/bin/bash

usage() {
  echo
  echo "Usage: $0 <imagesDir> <delay> <morph> <outFile>"
  echo
  exit 1
}

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ] || [ -z $4 ]; then
  usage
fi

IMAGES=$1
DELAY=$2
MORPH=$3
OUT=$(realpath $4)

LOCK_MD5=$(echo $OUT | md5sum | sed --regexp-extended 's/^([a-z0-9]+) .*$/\1/g')
LOCK="/tmp/makeSmootVideo_${LOCK_MD5}.lock"

log() {
  echo "$1" | tee --append $LOCK
}

BASE=$(dirname $0)
TEMP=$(mktemp -d) || exit
trap "rm -rf -- '$TEMP'" EXIT

if [ -f $LOCK ]; then
  echo "Lock file $LOCK exists. Stopping here."
  exit 1
fi

DATE=$(date)
log $DATE
log "------------------------"
log "IMAGES: $IMAGES"
log "DELAY:  $DELAY"
log "MORPH:  $MORPH"
log "TEMP:   $TEMP"
log "OUT:    $OUT"
log "LOCK:   $LOCK"
log "PID: $$"
log ""

log "Generating morph images ..."
convert $IMAGES/*.jpg -delay $DELAY -morph $MORPH $TEMP/%05d.jpg
log ""

log "Combining morph images into video ..."
avconv -i $TEMP/%05d.jpg -r 25 -map 0 -y $OUT
log ""

log "Removing $TEMP"
rm -rf $TEMP

log "Removing $LOCK"
rm $LOCK
