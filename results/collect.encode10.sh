#!/bin/bash

#suffix="v0.10.3.C"
#suffix=$1
#algo="stringtie"

results=../results/encode10

while getopts "a:x:p:r:g" arg
do
	case $arg in 
	a) 
		algo=$OPTARG
		;;
	x) 
		suffix=$OPTARG
		;;
	p) 
		comp=$OPTARG
		;;
	r) 
		aa=$OPTARG
		;;
	g) 
		results=../results/encode10-gtf
		;;
	esac
done

list=../data/encode10.list
gtfcuff=../programs/gtfcuff

#echo "#summary of multi-exon accuracy"
#echo "#accession aligner #total #correct sensitivity(%) precision(%)"

for x in `cat $list`
do
	id=`echo $x | cut -f 1 -d ":"`
	ss=`echo $x | cut -f 2 -d ":"`
	gm=`echo $x | cut -f 3 -d ":"`

	x0=`cat $results/$id.$aa/$algo.$suffix/gffmul.stats | grep Query | grep mRNAs | head -n 1 | awk '{print $5}'`
	x1=`cat $results/$id.$aa/$algo.$suffix/gffmul.stats | grep Matching | grep intron | grep chain | head -n 1 | awk '{print $4}'`
	x2=`cat $results/$id.$aa/$algo.$suffix/gffmul.stats | grep Intron | grep chain | head -n 1 | awk '{print $4}'`
	x3=`cat $results/$id.$aa/$algo.$suffix/gffmul.stats | grep Intron | grep chain | head -n 1 | awk '{print $6}'`

	total=`cat $results/$id.$aa/$algo.$suffix/gffmul.stats | grep Reference | grep mRNA | awk '{print $9}' | cut -f 2 -d "("`

	if [ "$x0" == "" ]; then x0="0"; fi
	if [ "$x1" == "" ]; then x1="0"; fi
	if [ "$x2" == "" ]; then x2="0"; fi
	if [ "$x3" == "" ]; then x3="0"; fi

	x2=`echo "scale = 2; 100 * $x1 / $total" | bc`
	x3=`echo "scale = 2; 100 * $x1 / $x0" | bc`

	p0="0"
	p1="0"
	p2="0"
	p3="0"

	if [ "$comp" != "" ]; then
		p0=`cat $results/$id.$aa/$algo.$comp/gffmul.stats | grep Query | grep mRNAs | head -n 1 | awk '{print $5}'`
		p1=`cat $results/$id.$aa/$algo.$comp/gffmul.stats | grep Matching | grep intron | grep chain | head -n 1 | awk '{print $4}'`
		p2=`cat $results/$id.$aa/$algo.$comp/gffmul.stats | grep Intron | grep chain | head -n 1 | awk '{print $4}'`
		p3=`cat $results/$id.$aa/$algo.$comp/gffmul.stats | grep Intron | grep chain | head -n 1 | awk '{print $6}'`

		p2=`echo "scale = 2; 100 * $p1 / $total" | bc`
		p3=`echo "scale = 2; 100 * $p1 / $p0" | bc`

		m1=""
		if [ "$x1" -gt "$p1" ]; then
			line=`$gtfcuff match-correct $results/$id.$aa/$algo.$suffix/gffmul.$algo.gtf.tmap $total $p1`
			mx1=`echo $line | cut -f 13 -d " "`
			mx2=`echo $line | cut -f 16 -d " "`
			m1="$mx1 $mx2 $p3"
		else
			line=`$gtfcuff match-correct $results/$id.$aa/$algo.$comp/gffmul.$algo.gtf.tmap $total $x1`
			mx1=`echo $line | cut -f 13 -d " "`
			mx2=`echo $line | cut -f 16 -d " "`
			m1="$mx1 $x3 $mx2"
		fi

		m2=""
		if (( $(echo "$x3 < $p3" | bc -l) )); then
			line=`$gtfcuff match-precision $results/$id.$aa/$algo.$suffix/gffmul.$algo.gtf.tmap $total $p3`
			mx1=`echo $line | cut -f 13 -d " "`
			mx2=`echo $line | cut -f 16 -d " "`
			m2="$mx2 $mx1 $p2"
		else
			line=`$gtfcuff match-precision $results/$id.$aa/$algo.$comp/gffmul.$algo.gtf.tmap $total $x3`
			mx1=`echo $line | cut -f 13 -d " "`
			mx2=`echo $line | cut -f 16 -d " "`
			m2="$mx2 $x2 $mx1"
		fi

		echo "$id $aa $x0 $x1 $x2 $x3 $p0 $p1 $p2 $p3 $total $m1 $m2"
	else
		echo "$id $aa $x0 $x1 $x2 $x3"
	fi
done
