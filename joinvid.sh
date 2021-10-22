#!/bin/bash

ffmpeg -i $1 -c copy -bsf:v h264_mp4toannexb -f mpegts temp1.ts &&\
    ffmpeg -i $2 -c copy -bsf:v h264_mp4toannexb -f mpegts temp2.ts &&\
    ffmpeg -i "concat:temp1.ts|temp2.ts" -c copy $3 &&\
    echo "remove the temp-files"
