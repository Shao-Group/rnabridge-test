#!/bin/bash

if [ "$#" != "5" ]; then
	echo "usage $0 id aligner algo tag1 tag2"
	exit
fi

results=../results/encode10
bin=../programs

id=$1
aa=$2
algo=$3
tag1=$4
tag2=$5

fx="$results/$id.$aa/$algo.$tag1/gffmul.stats"
fy="$results/$id.$aa/$algo.$tag2/gffmul.stats"
                                
tx="$results/$id.$aa/$algo.$tag1/gffmul.$algo.gtf.tmap"
ty="$results/$id.$aa/$algo.$tag2/gffmul.$algo.gtf.tmap"

sx=`cat $fx | grep Reference | grep mRNA | awk '{print $9}' | sed 's/(//g'`
sy=`cat $fy | grep Reference | grep mRNA | awk '{print $9}' | sed 's/(//g'`

x1=`cat $fx | grep Matching | grep intron | grep chain | awk '{print $4}'`
y1=`cat $fy | grep Matching | grep intron | grep chain | awk '{print $4}'`

x2=`cat $fx | grep Intron | grep chain | awk '{print $6}'`
y2=`cat $fy | grep Intron | grep chain | awk '{print $6}'`

xx1=$x1
xx2=$x2
yy1=$y1
yy2=$y2


if (( $(echo "$x2 >= $y2" | bc -l) )); then
	yy1=`$bin/gtfcuff match-precision $ty $sy $x2 | cut -f 10 -d " "`
	yy2=`$bin/gtfcuff match-precision $ty $sy $x2 | cut -f 16 -d " "`
else
	xx1=`$bin/gtfcuff match-precision $tx $sx $y2 | cut -f 10 -d " "`
	xx2=`$bin/gtfcuff match-precision $tx $sx $y2 | cut -f 16 -d " "`
fi

echo $id $xx1 $xx2 $yy1 $yy2
