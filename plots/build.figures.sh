#!/bin/bash

./summarize.encode10.sh D156
./summarize.encode65.sh D156
./summarize.gtex.sh D156

exit


./plot.gtex.sh D156 normal 10 6 9 5 Raw
./plot.gtex.sh D156 adjust 14 13 17 16 Adjusted

./plot.encode10.sh D156 adjust 14 13 17 16 Adjusted
./plot.encode65.sh D156 adjust 14 13 17 16 Adjusted
./plot.encode10.sh D156 normal 10 6 9 5 Raw
./plot.encode65.sh D156 normal 10 6 9 5 Raw
