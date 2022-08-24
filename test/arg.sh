#!/bin/bash

echo "hello world"
echo -e "\$0 -> $0"
echo -e "\$1 -> ${1:-no argument given}"
echo -e "\$$ -> $$"
