#!/bin/bash

if [ "$#" != "6" ]; then
	echo "usage $0 exe cur-dir bam-file gtf-file coverage strand"
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

{ /usr/bin/time -v $exe -i $bam -b coral.bam -r $gtf --library_type $strand > coral.log; } 2> time.log
#{ /usr/bin/time -v $exe -i $bam -b coral.bam --library_type $strand > coral.log; } 2> time.log
samtools sort -o coral.sort.bam -@ 4 coral.bam 

cd -
