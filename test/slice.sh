#/bin/bash

A=( foo bar "a  b c" 42 )
B=("${A[@]:1:2}")
C=("${A[@]:1}")       # slice to the end of the array
D=("${A[@]:0:100}")       # slice to the end of the array
echo "A -> ${A[@]}"        
echo "B -> ${B[@]}"       
echo "C -> ${C[@]}"      
echo "D -> ${D[@]}"      

echo "========"

echo "${B[@]}"        # bar a  b c
echo "${B[1]}"        # a  b c
echo "${C[@]}"        # bar a  b c 42
echo "${C[@]: -2:2}"
