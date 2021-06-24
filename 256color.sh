#!/bin/bash

# 4bit color
for i in {0..15}
do
	printf "\033[48;5;%sm%-9s" $i $i
done
echo -e "\033[0m"

# 6 * 6 * 6 = 216 color
for i in {16..231}; do
	printf "\033[48;5;%sm%-4s" $i $i
	var=$[ $i - 15 ]
	if [ $[$var % 36] -eq 0 ] && [ $[$var / 36] -gt 0 ] && [ $[$var / 36] -le 6 ]; then
		echo -e "\033[0m"
	fi
done

# 24 grayscale color
for i in {232..255}; do
	printf "\033[48;5;%sm%-6s" $i $i
done
echo -e "\033[0m"
