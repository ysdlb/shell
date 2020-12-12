for i in {16..231}; do
	var=$[ $i - 15 ]
	if [ $[$var % 32] -eq 0 ] && [ $[$var / 32] -gt 0 ] && [ $[$var / 32] -lt 6 ]; then
		echo yes
	fi
done
