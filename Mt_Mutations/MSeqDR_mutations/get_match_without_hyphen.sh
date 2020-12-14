#!/bin/bash
# exact word match without hyphen
#echo $1 $2

#grep -E "\b$1\b([^-]|$)" $2
filename=$1
filename2=$2
#n=1
while read line; do
# reading each line
#echo "Line No. $n : $line"
#n=$((n+1))
	grep -E "\b$line\b([^-]|$)" $filename2
done < $filename
