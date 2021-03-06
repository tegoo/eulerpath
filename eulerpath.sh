#!/bin/sh

EXPORT_DIR="paths"

if [ -d $EXPORT_DIR ]; then
	rm -rf "${EXPORT_DIR}"
fi

mkdir $EXPORT_DIR

snum=1
./run.pl | sed '
s/\[\([a-z]\),\([a-z]\)\]/\1->\2\;/g; 
s/\;,/;/g; 
s/,/\n/g;
s/\(.\)$/\1\n/; 
s/\]//g; 
s/\[//g;' | sed '/^$/d' | while read graph
do
	step=1
	printf "digraph {"
	printf "node [shape=circle, fontcolor=yellow, style=filled, fillcolor=black];"
	printf $graph | sed 's/;/\n/g' | while read edge
	do
		if [ "${step}" -eq "1" ]
		then
			printf $edge | sed 's/^\([a-z]\).*/\1/'
			printf "[style=filled, fillcolor=yellow, shape=doublecircle, fontcolor=black];"
		fi
		printf "${edge} [label=\"${step}\"];"
		step=$((step+1))
	done
	printf "}\n"
done | while read graph
do
	echo $graph | circo -Tpng -o "${EXPORT_DIR}/path_${snum}.png"
	snum=$((snum+1))
done
