#! /bin/bash
cat combo.txt | while read LINE; 
do
 echo $LINE
testcafe  -c 2 $LINE test.js
done