#!/bin/bash

echo "file: " 

for i in "$1"/*;do
echo $i
s=$i
echo ${s##*/}
s=${s##*/}
echo ${s%.txt}
formula=${s%.txt}
sirius -f $formula -i [M+H]+ -2 $i $i -o "output"
done 
