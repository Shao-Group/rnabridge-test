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

# run stringtie
mkdir -p $cur/stringtie
cd $cur/stringtie

if [ "$strand" == "first" ]; then
	ss="--rf"
elif [ "$strand" == "second" ]; then
	ss="--fr"
fi

if [ "$coverage" == "default" ]
then
	{ /usr/bin/time -v $bin/stringtie $cur/coral.sort.bam -o stringtie.gtf $ss > stringtie.log; } 2> time.log
else
	{ /usr/bin/time -v $bin/stringtie $cur/coral.sort.bam -o stringtie.gtf $ss -c $coverage > stringtie.log; } 2> time.log
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
