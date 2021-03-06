#!/bin/bash

# This script is useful for generating output slowed at a rate of 0.991 
# which is handy for use with pifm.

# https://github.com/faithanalog/pifm

# https://github.com/faithanalog/pagerenc
MESSAGE_ENCODER=pagerenc

if [[ $# < 2 ]]; then
    echo "Usage: $0 <messagefile> <outfile>" 1>&2
else
    #Inverts audio, and slows down to speed of 0.991
    #We use cat here since it handles '-' properly for stdin
    cat "$1" \
        | "$MESSAGE_ENCODER" \
        | ffmpeg -loglevel 16 -f s16le -ar 22050 -ac 1 -i - -af 'volume=-0.75' -f wav - \
        | sox -V1 -t wav - -t wav "$2" speed 0.991
fi
