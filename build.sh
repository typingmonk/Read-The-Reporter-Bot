#!/bin/bash

BASEDIR=$PWD

# create essential file and folder
cp $BASEDIR/config.example.py $BASEDIR/config.py
cp $BASEDIR/cron.example $BASEDIR/cron
cp $BASEDIR/toot.example.sh $BASEDIR/toot.sh
[[ ! -d $BASEDIR/rss_feed ]] && mkdir $BASEDIR/rss_feed

# create python venv
if [[ ! -d $BASEDIR/venv ]] ; then
	python3 -m venv $BASEDIR/venv
	$BASEDIR/venv/bin/pip install -r $BASEDIR/requirements.txt
fi

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
