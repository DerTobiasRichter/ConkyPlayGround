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
# Slave Script of the picloader script. 
#
# Parameter01: Shell Date based date aka. 2 week ago / 2 year ago /..
# Parameter02: OUTPUT_FOLDER path string
#
# =============================================================================

# Vars - touch with care
STOP_DATE=$(date --date="$1")
OUTPUT_FOLDER=$2
NOW_DATE=$(date -d 'now')
FILEEXT='gif'

###############################################################################
# Script
###############################################################################

if [ ! -d $OUTPUT_FOLDER ]
then
	mkdir $OUTPUT_FOLDER
fi

STRING_STOP_DATE=$(date -d "$STOP_DATE" +'%Y-%m-%d')
STRING_IMAGE_DATE=$(date -d "$NOW_DATE" +'%Y-%m-%d')

IMAGE_DATE=$NOW_DATE
counter=0
while [ "$STRING_STOP_DATE" != "$STRING_IMAGE_DATE" ]
do
	#read -rsp $'Press any key to continue...\n' -n 1 key
	counter=$(( $counter + 1 ))
	IMAGE_DATE=$(date --date="-$counter  day")
	FOLDER_YEAR=$(date -d "$IMAGE_DATE" +'%Y')
	STRING_IMAGE_DATE=$(date -d "$IMAGE_DATE" +'%Y-%m-%d')
	URL=https://d1ejxu6vysztl5.cloudfront.net/comics/garfield/$FOLDER_YEAR/$STRING_IMAGE_DATE.$FILEEXT
	OUT=$OUTPUT_FOLDER/$STRING_IMAGE_DATE.$FILEEXT
	echo "URL:" $URL
	echo "OUT:" $OUT
	if curl -L $URL --create-dirs --create-dirs -o $OUT; then
		echo done
	fi
done
# clean
for filename in $OUTPUT_FOLDER/*.gif; do
    [ -e "$filename" ] || continue
    
    if ! file $filename | grep -qE 'image|bitmap' || ! identify "$filename" >/dev/null 2>&1; then
        #echo "rm $filename"
        rm -vf $filename
    fi
    echo $filename
    continue

done