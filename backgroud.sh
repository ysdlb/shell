for b in {0..7} 9; do
    for f in {0..7} 9; do
	for attr in "" bold; do
	    echo -e "$(tput setab $b; tput setaf $f; [ -n "$attr" ] && tput $attr) $f ON $b $attr $(tput sgr0)";
	done;
    done;
done
