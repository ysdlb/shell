#!/bin/bash

red=$1
green=0
blue=0
for g in {0..255}; do
    green=${g}
    for b in {0..255}; do
	blue=${b}
        echo -en "\x1b[38;2;${red};${green};${blue}mx"
    done
    #echo "\n${red}-${green}-${blue}"
    echo ""
done
