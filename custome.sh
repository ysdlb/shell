#!/bin/bash
if [ $1 = r ]; then a=$2
elif [ $1 = g ]; then b=$2
elif [ $1 = b ]; then c=$2
fi
for i in {0..255}; do
	for j in {0..255}; do
		printf "\x1b[48;2;%s;%s;%sm " $a $i $b $j $c
	done
	echo -e "\x1b[0m"
done
