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
strand=""

if [ "$6" == "first" ]; then
	strand="--rf"
elif [ "$6" == "second" ]; then
	strand="--fr"
fi

mkdir -p $cur

cd $cur

#if [ -s stringtie.gtf ]; then
#	exit
#fi

if [ "$coverage" == "default" ]
then
	{ /usr/bin/time -v $exe $bam -o stringtie.gtf $strand > stringtie.log; } 2> time.log
else
	{ /usr/bin/time -v $exe $bam -o stringtie.gtf $strand -c $coverage > stringtie.log; } 2> time.log
fi

cat stringtie.gtf | sed 's/^chr//g' > stringtie.tmp.xxx.gtf
mv stringtie.tmp.xxx.gtf stringtie.gtf

$bin/gffcompare -o gffmul -r $gtf stringtie.gtf -M -N
$bin/gffcompare -o gffall -r $gtf stringtie.gtf
$bin/gtfcuff acc-single gffall.stringtie.gtf.tmap > gffall.single
$bin/gtfcuff classify gffmul.stringtie.gtf.tmap stringtie.gtf > gffmul.class

if [ "$#" == "7" ]; then
	$bin/gtfcuff acc-quant gffmul.stringtie.gtf.tmap $7 0.1 > gffmul.quant
fi

cd -
