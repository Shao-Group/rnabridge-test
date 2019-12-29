#!/bin/bash

./plot.gtex.sh D156 normal 5 9 4 8 Raw
./plot.gtex.sh D156 adjusted 12 13 15 16 Adjusted

exit

./plot.encode10.sh D156 adjust 14 13 17 16 Adjusted
./plot.encode65.sh D156 adjust 14 13 17 16 Adjusted
./plot.encode10.sh D156 normal 10 6 9 5 Raw
./plot.encode65.sh D156 normal 10 6 9 5 Raw
