#!/bin/bash

if [ "$#" != "4" ]; then
	echo "ID aligner algo1 algo2"
	exit
fi

results=../results/encode10

id=$1
aa=$2
algo1=$3
algo2=$4
algos="$algo1 $algo2"

cc=""
for bb in `echo $algos`
do
	x0=`cat $results/$id.$aa/$bb/gffmul.stats | grep Query | grep mRNAs | head -n 1 | awk '{print $5}'`
	x1=`cat $results/$id.$aa/$bb/gffmul.stats | grep Matching | grep intron | grep chain | head -n 1 | awk '{print $4}'`
	x2=`cat $results/$id.$aa/$bb/gffmul.stats | grep Intron | grep chain | head -n 1 | awk '{print $4}'`
	x3=`cat $results/$id.$aa/$bb/gffmul.stats | grep Intron | grep chain | head -n 1 | awk '{print $6}'`

	if [ "$x0" == "" ]; then x0="0"; fi
	if [ "$x1" == "" ]; then x1="0"; fi
	if [ "$x2" == "" ]; then x2="0"; fi
	if [ "$x3" == "" ]; then x3="0"; fi

	cc="$cc$x1 $x3 "
done

echo $id $cc
