#!/bin/bash


while [[ -z ${input} ]]
do
	echo "set input"
	read -p "->: " input
	echo ${input}
done
