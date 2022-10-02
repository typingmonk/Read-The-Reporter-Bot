#!/bin/bash

BASEDIR=$(dirname "$0")
echo "$BASEDIR"

# create essential file and folder

cp $BASEDIR/config.example.py $BASEDIR/config.py
mkdir $BASEDIR/rss_feed

# create python venv
python3 -m venv $BASEDIR/bot_venv
