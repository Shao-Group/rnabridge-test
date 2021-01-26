#!/bin/bash

#suffix="v0.10.3.C"
#suffix=$1
#algo="stringtie"

results=../results/encode10

while getopts "a:x:p:q:r:g" arg
do
	case $arg in 
	a) 
		algo=$OPTARG
		;;
	x) 
		suffix=$OPTARG
		;;
	p) 
		comp1=$OPTARG
		;;
	q) 
		comp2=$OPTARG
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

	# total: #transcripts in reference annotation
	total=`cat $results/$id.$aa/$algo.$suffix/gffmul.stats | grep Reference | grep mRNA | awk '{print $9}' | cut -f 2 -d "("`

	# x0: #predicted transcripts
	# x1: #correct transcripts
	# x2: recall
	# x3: precision
	# Coral without reference
	x0=`cat $results/$id.$aa/$algo.$suffix/gffmul.stats | grep Query | grep mRNAs | head -n 1 | awk '{print $5}'`
	x1=`cat $results/$id.$aa/$algo.$suffix/gffmul.$algo.gtf.tmap | grep = | wc -l`
	x2=`echo "scale = 2; 100 * $x1 / $total" | bc`
	x3=`echo "scale = 2; 100 * $x1 / $x0" | bc`

	# Coral with reference
	y0=`cat $results/$id.$aa/$algo.$comp2/gffmul.stats | grep Query | grep mRNAs | head -n 1 | awk '{print $5}'`
	y1=`cat $results/$id.$aa/$algo.$comp2/gffmul.$algo.gtf.tmap | grep = | wc -l`
	y2=`echo "scale = 2; 100 * $y1 / $total" | bc`
	y3=`echo "scale = 2; 100 * $y1 / $y0" | bc`

	# without Coral
	p0=`cat $results/$id.$aa/$algo.$comp1/gffmul.stats | grep Query | grep mRNAs | head -n 1 | awk '{print $5}'`
	p1=`cat $results/$id.$aa/$algo.$comp1/gffmul.$algo.gtf.tmap | grep = | wc -l`
	p2=`echo "scale = 2; 100 * $p1 / $total" | bc`
	p3=`echo "scale = 2; 100 * $p1 / $p0" | bc`

	# adjusted to match recall
	# m1 = #matched-transcripts #adjusted-precision-coral-w/o-ref #adjusted-precision-coral-w/-ref #adjusted-precision-w/o-coral
	m1=""
	if [ "$x1" -gt "$p1" ] && [ "$y1" -gt "$p1" ]; then
		linex=`$gtfcuff match-correct $results/$id.$aa/$algo.$suffix/gffmul.$algo.gtf.tmap $total $p1`
		liney=`$gtfcuff match-correct $results/$id.$aa/$algo.$comp2/gffmul.$algo.gtf.tmap $total $p1`
		mx=`echo $linex | cut -f 16 -d " "`
		my=`echo $liney | cut -f 16 -d " "`
		m1="$p1 $my $mx $p3"
	elif [ "$y1" -gt "$x1" ] && [ "$p1" -gt "$x1" ]; then
		liney=`$gtfcuff match-correct $results/$id.$aa/$algo.$comp2/gffmul.$algo.gtf.tmap $total $x1`
		linep=`$gtfcuff match-correct $results/$id.$aa/$algo.$comp1/gffmul.$algo.gtf.tmap $total $x1`
		my=`echo $liney | cut -f 16 -d " "`
		mp=`echo $linep | cut -f 16 -d " "`
		m1="$x1 $my $x3 $mp"
	else
		linex=`$gtfcuff match-correct $results/$id.$aa/$algo.$suffix/gffmul.$algo.gtf.tmap $total $y1`
		linep=`$gtfcuff match-correct $results/$id.$aa/$algo.$comp1/gffmul.$algo.gtf.tmap $total $y1`
		mx=`echo $liney | cut -f 16 -d " "`
		mp=`echo $linep | cut -f 16 -d " "`
		m1="$y1 $y3 $mx $mp"
	fi

	# adjusted to match precision
	# m1 = #matched-precision #adjusted-correct-transcripts-coral-w/o-ref #adjusted-correct-transcripts-coral-w/-ref #adjusted-correct-transcripts-w/o-coral
	m2=""
	if (( $(echo "$x3 < $p3" | bc -l) )) && (( $(echo "$y3 < $p3" | bc -l) )); then
		linex=`$gtfcuff match-precision $results/$id.$aa/$algo.$suffix/gffmul.$algo.gtf.tmap $total $p3`
		liney=`$gtfcuff match-precision $results/$id.$aa/$algo.$comp2/gffmul.$algo.gtf.tmap $total $p3`
		mx=`echo $linex | cut -f 10 -d " "`
		my=`echo $liney | cut -f 10 -d " "`
		m2="$p3 $my $mx $p1"
	elif (( $(echo "$p3 < $x3" | bc -l) )) && (( $(echo "$y3 < $x3" | bc -l) )); then
		liney=`$gtfcuff match-precision $results/$id.$aa/$algo.$comp2/gffmul.$algo.gtf.tmap $total $x3`
		linep=`$gtfcuff match-precision $results/$id.$aa/$algo.$comp1/gffmul.$algo.gtf.tmap $total $x3`
		my=`echo $liney | cut -f 10 -d " "`
		mp=`echo $linep | cut -f 10 -d " "`
		m2="$x3 $my $x1 $mp"
	else
		linex=`$gtfcuff match-precision $results/$id.$aa/$algo.$suffix/gffmul.$algo.gtf.tmap $total $y3`
		linep=`$gtfcuff match-precision $results/$id.$aa/$algo.$comp1/gffmul.$algo.gtf.tmap $total $y3`
		mx=`echo $linex | cut -f 10 -d " "`
		mp=`echo $linep | cut -f 10 -d " "`
		m2="$y3 $y1 $mx $mp"
	fi

	echo $id $aa $total $y0 $y1 $y2 $y3 $x0 $x1 $x2 $x3 $p0 $p1 $p2 $p3 $m1 $m2
done
