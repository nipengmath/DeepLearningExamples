#!/usr/bin/env bash

set -e

DATADIR="biaobei"
#BZ2ARCHIVE="${DATADIR}.tar.bz2"
#ENDPOINT="http://data.keithito.com/data/speech/$BZ2ARCHIVE"
FILELISTSDIR="filelists"
FULLLIST="$FILELISTSDIR/ljs_audio_text_filelist.txt"
TESTLIST="$FILELISTSDIR/ljs_audio_text_test_filelist.txt"
TRAINLIST="$FILELISTSDIR/ljs_audio_text_train_filelist.txt"
VALLIST="$FILELISTSDIR/ljs_audio_text_val_filelist.txt"
SUBSETLIST="$FILELISTSDIR/ljs_audio_text_train_subset_filelist.txt"

if [ ! -d "$DATADIR" ]; then
  echo "dataset is missing, unpacking ..."
  if [ ! -f "$BZ2ARCHIVE" ]; then
    echo "dataset archive is missing, downloading ..."
    wget "$ENDPOINT"
  fi
  tar jxvf "$BZ2ARCHIVE"
fi

if [ ! -d "$FILELISTSDIR" ]; then
  echo "missing filelists directory, regenerating ..."
  mkdir "$FILELISTSDIR"
  if [ ! -f "$FULLLIST" ]; then
    cat "$DATADIR/metadata.csv" | sed "s%^\([^|]*\)|[^|]*|\([^|]*\)$%$DATADIR/wavs/\1.wav|\2%g" \
      > $FULLLIST
  fi
  if [ ! -f "$TRAINLIST" ]; then
    head -n 9000 "$FULLLIST" > $TRAINLIST
  fi
  if [ ! -f "$TESTLIST" ]; then
    head -n 9500 "$FULLLIST" | tail -n 500 "$FULLLIST" > $TESTLIST
  fi
  if [ ! -f "$VALLIST" ]; then
    head -n 10000 "$FULLLIST" | tail -n 500 "$FULLLIST" > $VALLIST
  fi
  if [ ! -f "$SUBSETLIST" ]; then
    head -n 1000 "$TRAINLIST" > $SUBSETLIST
  fi
fi
