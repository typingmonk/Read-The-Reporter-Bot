#!/bin/bash

BASEDIR=$PWD

# create essential file and folder
cp $BASEDIR/config.example.py $BASEDIR/config.py
mkdir $BASEDIR/rss_feed

# create python venv
python3 -m venv $BASEDIR/bot_venv

# copy cron.example    -> cron
#      toot.example.sh -> toot.sh
cp $BASEDIR/cron.example $BASEDIR/cron
cp $BASEDIR/toot.example.sh $BASEDIR/toot.sh

# substitute {BASEDIR} in cron and toot.sh
##### for GNU sed
if sed -i "s {BASEDIR} $BASEDIR g" $BASEDIR/toot.sh 2>/dev/null ; then
	sed -i "s {BASEDIR} $BASEDIR g" $BASEDIR/cron
##### For FreeBSD sed 
else
	sed -i "" "s {BASEDIR} $BASEDIR g" $BASEDIR/toot.sh 
	sed -i "" "s {BASEDIR} $BASEDIR g" $BASEDIR/cron
fi

# make .sh file executable.
chmod +x $BASEDIR/toot.sh
