#!/bin/bash

if [ "$#" != "7" ] && [ "$#" != "6" ]; then
	echo "usage $0 exe cur-dir bam-file gtf-file coverage strand [-gtf]"
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

ppp=`dirname $bam`
log=$ppp/coral.log
median=`cat $log | grep preview | grep insertsize | head -n 1 | awk '{print $14}' | cut -f 1 -d ","`
low=`cat $log | grep preview | grep insertsize | head -n 1 | awk '{print $17}' | cut -f 1 -d ","`
high=`cat $log | grep preview | grep insertsize | head -n 1 | awk '{print $20}' | cut -f 1 -d ","`

if [ "$#" == "7" ] && [ "$7" == "-gtf" ]; then
#{ /usr/bin/time -v $exe -i $bam -b coral.bam --insertsize_median $median --insertsize_low $low --insertsize_high $high -r $gtf --library_type $strand > coral.log; } 2> time.log
	{ /usr/bin/time -v $exe -i $bam -b coral.bam -r $gtf --library_type $strand > coral.log; } 2> time.log
else
	{ /usr/bin/time -v $exe -i $bam -b coral.bam --library_type $strand > coral.log; } 2> time.log
fi

#{ /usr/bin/time -v $exe -i $bam -b coral.bam --library_type unstranded > coral.log; } 2> time.log
samtools sort -o coral.sort.bam -@ 4 coral.bam 

cd -
