#!/bin/bash

BASEDIR=$PWD

# create essential file and folder
cp $BASEDIR/config.example.py $BASEDIR/config.py
mkdir $BASEDIR/rss_feed

# make .sh file executable.
chmod +x $BASEDIR/toot.sh

# create python venv
python3 -m venv $BASEDIR/bot_venv

# substitute {BASEDIR} in cron and toot.sh
sed -i "s {BASEDIR} $BASEDIR g" $BASEDIR/toot.sh
sed -i "s {BASEDIR} $BASEDIR g" $BASEDIR/cron
