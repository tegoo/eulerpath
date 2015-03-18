#!/bin/sh

EXPORT_DIR="paths"

if [ -d $EXPORT_DIR ]; then
	rm -rf "${EXPORT_DIR}"
fi

mkdir $EXPORT_DIR

i=0
./run.pl | sed \
's/\[\([a-z]\),\([a-z]\)\]/\1->\2\;/g; 
 s/\;,/;/g; s/,/\n/g; s/\]//g; 
 s/\[//g;' | sed 's/^\(.*\)$/digraph {\1}/' | while read graph
 do
 	i=$((i+1))
 	echo $graph | dot -Tpng -o "paths/path_${i}.png"
 done