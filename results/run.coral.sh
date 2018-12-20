#!/bin/bash

if [ "$#" != "6" ] && [ "$#" != "7" ]; then
	echo "usage $0 exe cur-dir bam-file gtf-file coverage strand [quantfile]"
	exit
fi

bin=/storage/home/m/mxs2589/group/projects/coraltest/programs
exe=$1
cur=$2
bam=$3
gtf=$4
coverage=$5
strand=$6

mkdir -p $cur

cd $cur

{ /usr/bin/time -v $exe -i $bam -o coral.bam > coral.log; } 2> time.log
samtools sort coral.bam coral.sort

cd -
