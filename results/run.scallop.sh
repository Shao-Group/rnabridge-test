#!/bin/bash

if [ "$#" != "6" ] && [ "$#" != "7" ]; then
	echo "usage $0 cur-dir exe bam-file gtf-file coverage strand [quantfile]"
	exit
fi

bin=/home/mxs2589/shao/project/coraltest/programs
exe=$1
cur=$2
bam=$3
gtf=$4
coverage=$5
strand=$6

mkdir -p $cur

cd $cur

if [ "$coverage" == "default" ]
then
	{ /usr/bin/time -v $exe -i $bam -o scallop.gtf --max_num_cigar 100 --library_type $strand > scallop.log; } 2> time.log
else
	{ /usr/bin/time -v $exe -i $bam -o scallop.gtf --max_num_cigar 100 --library_type $strand -c $coverage > scallop.log; } 2> time.log
fi

cat scallop.gtf | sed 's/^chr//g' > scallop.tmp.xxx.gtf
mv scallop.tmp.xxx.gtf scallop.gtf

$bin/gffcompare -o gffmul -r $gtf scallop.gtf -M -N
$bin/gffcompare -o gffall -r $gtf scallop.gtf
$bin/gtfcuff acc-single gffall.scallop.gtf.tmap > gffall.single
$bin/gtfcuff classify gffmul.scallop.gtf.tmap scallop.gtf > gffmul.class

if [ "$#" == "7" ]; then
	$bin/gtfcuff acc-quant gffmul.scallop.gtf.tmap $7 0.1 > gffmul.quant
fi

cd -
