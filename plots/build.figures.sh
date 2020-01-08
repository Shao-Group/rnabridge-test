#!/bin/bash

./summarize.encode10.sh D156
./summarize.encode65.sh D156

exit

./plot.encode10.sh D156 normal 15 7 11 13 5 9 Raw
./plot.encode10.sh D156 adjust 19 17 18 23 21 22 Adjusted
./plot.encode65.sh D156 normal 15 7 11 13 5 9 Raw
./plot.encode65.sh D156 adjust 19 17 18 23 21 22 Adjusted

#./summarize.gtex.sh D156

exit


./plot.gtex.sh D156 normal 10 6 9 5 Raw
./plot.gtex.sh D156 adjust 14 13 17 16 Adjusted

./plot.encode10.sh D156 adjust 14 13 17 16 Adjusted
./plot.encode65.sh D156 adjust 14 13 17 16 Adjusted
./plot.encode10.sh D156 normal 10 6 9 5 Raw
./plot.encode65.sh D156 normal 10 6 9 5 Raw
