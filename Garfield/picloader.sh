#!/bin/bash

# =============================================================================
#                               garfield
# Date    : 24/08/2019
# Author  : Tobias.Richter@de.ibm.com
# Version : v1.0
# License : Distributed under the terms of GNU GPL version 2 or later
# 
# Simple daily PicDownLoader with config for Garfield Comic Strips. Hail to Jim Davis.
# 
# =============================================================================

# Vars for API/URL Bindings - touch with care
IMAGEDATE=$(date +'%Y-%m-%d')
IMAGEYEAR=$(date +'%Y')
FILEEXT='gif'

# Vars to edit :)
URL=https://d1ejxu6vysztl5.cloudfront.net/comics/garfield/$IMAGEYEAR/$IMAGEDATE.$FILEEXT

OUTPUT_FOLDER=~/Pictures/Conky/Garfield
LOAD_GARFIELD_SINCE="2 years ago"

###############################################################################
# Script
###############################################################################

# check env
if [ ! -d $OUTPUT_FOLDER ]
then
	mkdir $OUTPUT_FOLDER
fi

# load lots of strips for endless fun
if [ ! "$(find "$OUTPUT_FOLDER"  -mindepth 1 -print -quit 2>/dev/null)" ]
then
	echo "load "LOAD_GARFIELD_SINCE" of Garfield" 
	. picsucker.sh "$LOAD_GARFIELD_SINCE" "$OUTPUT_FOLDER"
fi

# load daily garfield
if [ ! -f $OUTPUT_FOLDER/$IMAGEDATE.$FILEEXT ]
then
	#echo "Found NoGarfield Date matches: "$(grep -c "$IMAGEDATE" $OUTPUT_FOLDER/nogarfield.log)
	if [ ! "$(grep -c "$IMAGEDATE" $OUTPUT_FOLDER/nogarfield.log)" -ge 1 ]
	then
		echo "curl: " $URL
		curl -C - $URL --create-dirs -o $OUTPUT_FOLDER/$IMAGEDATE.$FILEEXT
		if ! file $OUTPUT_FOLDER/$IMAGEDATE.$FILEEXT | grep -qE 'image|bitmap' || ! identify "$FILE" >/dev/null 2>&1
		then
			rm -vf $OUTPUT_FOLDER/$IMAGEDATE.$FILEEXT
			touch $OUTPUT_FOLDER/nogarfield.log
			echo $IMAGEDATE > $OUTPUT_FOLDER/nogarfield.log
		fi
	else
		#echo "No Garfield today :("
	fi
fi

# random find, resize and provide one/three line comic strips in matching ratio
if [ "$(find "$OUTPUT_FOLDER"  -mindepth 1 -print -quit 2>/dev/null)" ]
then
	RANDOM_IMAGE=$(find ~/Pictures/Conky -type f | shuf -n 1)

	IDENTIFY_REGEX_ONELINE=$(identify "$RANDOM_IMAGE")
	IDENTIFY_REGEX_THREELINE=$(identify "$RANDOM_IMAGE")

	if [[ $IDENTIFY_REGEX_ONELINE =~ 1200x3[0-9][0-9] ]] && [ "$1" == "ONELINE" ]
	then 
		#echo "IDENTIFY_REGEX_ONELINE"
		convert "$RANDOM_IMAGE" -resize x268 $OUTPUT_FOLDER/dailyconky-oneline.$FILEEXT
	else
		if [[ $IDENTIFY_REGEX_THREELINE =~ 1200x[7-9][0-9][0-9] ]] && [ "$1" == "THREELINE" ]
		then 
			#echo "IDENTIFY_REGEX_THREELINE"
			convert "$RANDOM_IMAGE" -resize x600 $OUTPUT_FOLDER/dailyconky-theeline.$FILEEXT
		fi
	fi
fi
