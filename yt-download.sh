#!/bin/bash

if [ -z "$1" ]; then
    echo "no id supplied"
fi

if [ -z "$2" ]; then
    echo "no artist supplied"
fi

if [ -z "$3" ]; then
    echo "no title supplied"
fi

artist="$2"
title="$3"

youtube-dl -x --add-metadata --embed-thumbnail --audio-format mp3 -o "$artist - $title - tmp.%(ext)s" "https://www.youtube.com/watch?v=$1" && ffmpeg -i "$artist - $title - tmp.mp3" -c copy -metadata Artist="$artist" -metadata Title="$title" "$artist - $title.mp3" && rm "$artist - $title - tmp.mp3"
