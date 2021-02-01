#!/bin/bash

aa="star"
algo1="scallop"
algo2="scallop"
algo3="scallop"
algo4="stringtie"
algo5="stringtie"
comp1="cd3300"
comp2="D400"
comp3="0.10.5"
comp4="D400"
comp5="2.1.4"

results=../results/encode10
list=../data/encode10.list
gtfcuff=../programs/gtfcuff

for x in `cat $list`
do
	id=`echo $x | cut -f 1 -d ":"`
	ss=`echo $x | cut -f 2 -d ":"`
	gm=`echo $x | cut -f 3 -d ":"`

	# total: #transcripts in reference annotation
	total=`cat $results/$id.$aa/$algo1.$comp1/gffmul.stats | grep Reference | grep mRNA | awk '{print $9}' | cut -f 2 -d "("`

	# x0: #predicted transcripts
	# x1: #correct transcripts
	# x2: recall
	# x3: precision

	a0=`cat $results/$id.$aa/$algo1.$comp1/gffmul.stats | grep Query | grep mRNAs | head -n 1 | awk '{print $5}'`
	a1=`cat $results/$id.$aa/$algo1.$comp1/gffmul.$algo1.gtf.tmap | grep = | wc -l`
	a2=`echo "scale = 2; 100 * $a1 / $total" | bc`
	a3=`echo "scale = 2; 100 * $a1 / $a0" | bc`

	b0=`cat $results/$id.$aa/$algo2.$comp2/gffmul.stats | grep Query | grep mRNAs | head -n 1 | awk '{print $5}'`
	b1=`cat $results/$id.$aa/$algo2.$comp2/gffmul.$algo2.gtf.tmap | grep = | wc -l`
	b2=`echo "scale = 2; 100 * $b1 / $total" | bc`
	b3=`echo "scale = 2; 100 * $b1 / $b0" | bc`

	c0=`cat $results/$id.$aa/$algo3.$comp3/gffmul.stats | grep Query | grep mRNAs | head -n 1 | awk '{print $5}'`
	c1=`cat $results/$id.$aa/$algo3.$comp3/gffmul.$algo3.gtf.tmap | grep = | wc -l`
	c2=`echo "scale = 2; 100 * $c1 / $total" | bc`
	c3=`echo "scale = 2; 100 * $c1 / $c0" | bc`

	d0=`cat $results/$id.$aa/$algo4.$comp4/gffmul.stats | grep Query | grep mRNAs | head -n 1 | awk '{print $5}'`
	d1=`cat $results/$id.$aa/$algo4.$comp4/gffmul.$algo4.gtf.tmap | grep = | wc -l`
	d2=`echo "scale = 2; 100 * $d1 / $total" | bc`
	d3=`echo "scale = 2; 100 * $d1 / $d0" | bc`

	e0=`cat $results/$id.$aa/$algo5.$comp5/gffmul.stats | grep Query | grep mRNAs | head -n 1 | awk '{print $5}'`
	e1=`cat $results/$id.$aa/$algo5.$comp5/gffmul.$algo5.gtf.tmap | grep = | wc -l`
	e2=`echo "scale = 2; 100 * $e1 / $total" | bc`
	e3=`echo "scale = 2; 100 * $e1 / $e0" | bc`


	# adjusted to match recall
	# m1 = #matched-transcripts #adjusted-precision-coral-w/o-ref #adjusted-precision-coral-w/-ref #adjusted-precision-w/o-coral
	m1=""
	if [ "$b1" -gt "$a1" ] && [ "$c1" -gt "$a1" ] && [ "$d1" -gt "$a1" ] && [ "$e1" -gt "$a1" ]; then
		linea=`$gtfcuff match-correct $results/$id.$aa/$algo1.$comp1/gffmul.$algo1.gtf.tmap $total $a1`
		lineb=`$gtfcuff match-correct $results/$id.$aa/$algo2.$comp2/gffmul.$algo2.gtf.tmap $total $a1`
		linec=`$gtfcuff match-correct $results/$id.$aa/$algo3.$comp3/gffmul.$algo3.gtf.tmap $total $a1`
		lined=`$gtfcuff match-correct $results/$id.$aa/$algo4.$comp4/gffmul.$algo4.gtf.tmap $total $a1`
		linee=`$gtfcuff match-correct $results/$id.$aa/$algo5.$comp5/gffmul.$algo5.gtf.tmap $total $a1`
		ma=`echo $linea | cut -f 16 -d " "`
		mb=`echo $lineb | cut -f 16 -d " "`
		mc=`echo $linec | cut -f 16 -d " "`
		md=`echo $lined | cut -f 16 -d " "`
		me=`echo $linee | cut -f 16 -d " "`
		m1="$a1 $ma $mb $mc $md $me"
	elif [ "$a1" -gt "$b1" ] && [ "$c1" -gt "$b1" ] && [ "$d1" -gt "$b1" ] && [ "$e1" -gt "$b1" ]; then
		linea=`$gtfcuff match-correct $results/$id.$aa/$algo1.$comp1/gffmul.$algo1.gtf.tmap $total $b1`
		lineb=`$gtfcuff match-correct $results/$id.$aa/$algo2.$comp2/gffmul.$algo2.gtf.tmap $total $b1`
		linec=`$gtfcuff match-correct $results/$id.$aa/$algo3.$comp3/gffmul.$algo3.gtf.tmap $total $b1`
		lined=`$gtfcuff match-correct $results/$id.$aa/$algo4.$comp4/gffmul.$algo4.gtf.tmap $total $b1`
		linee=`$gtfcuff match-correct $results/$id.$aa/$algo5.$comp5/gffmul.$algo5.gtf.tmap $total $b1`
		ma=`echo $linea | cut -f 16 -d " "`
		mb=`echo $lineb | cut -f 16 -d " "`
		mc=`echo $linec | cut -f 16 -d " "`
		md=`echo $lined | cut -f 16 -d " "`
		me=`echo $linee | cut -f 16 -d " "`
		m1="$b1 $ma $mb $mc $md $me"
	elif [ "$b1" -gt "$c1" ] && [ "$a1" -gt "$c1" ] && [ "$d1" -gt "$c1" ] && [ "$e1" -gt "$c1" ]; then
		linea=`$gtfcuff match-correct $results/$id.$aa/$algo1.$comp1/gffmul.$algo1.gtf.tmap $total $c1`
		lineb=`$gtfcuff match-correct $results/$id.$aa/$algo2.$comp2/gffmul.$algo2.gtf.tmap $total $c1`
		linec=`$gtfcuff match-correct $results/$id.$aa/$algo3.$comp3/gffmul.$algo3.gtf.tmap $total $c1`
		lined=`$gtfcuff match-correct $results/$id.$aa/$algo4.$comp4/gffmul.$algo4.gtf.tmap $total $c1`
		linee=`$gtfcuff match-correct $results/$id.$aa/$algo5.$comp5/gffmul.$algo5.gtf.tmap $total $c1`
		ma=`echo $linea | cut -f 16 -d " "`
		mb=`echo $lineb | cut -f 16 -d " "`
		mc=`echo $linec | cut -f 16 -d " "`
		md=`echo $lined | cut -f 16 -d " "`
		me=`echo $linee | cut -f 16 -d " "`
		m1="$c1 $ma $mb $mc $md $me"
	elif [ "$b1" -gt "$d1" ] && [ "$c1" -gt "$d1" ] && [ "$a1" -gt "$d1" ] && [ "$e1" -gt "$d1" ]; then
		linea=`$gtfcuff match-correct $results/$id.$aa/$algo1.$comp1/gffmul.$algo1.gtf.tmap $total $d1`
		lineb=`$gtfcuff match-correct $results/$id.$aa/$algo2.$comp2/gffmul.$algo2.gtf.tmap $total $d1`
		linec=`$gtfcuff match-correct $results/$id.$aa/$algo3.$comp3/gffmul.$algo3.gtf.tmap $total $d1`
		lined=`$gtfcuff match-correct $results/$id.$aa/$algo4.$comp4/gffmul.$algo4.gtf.tmap $total $d1`
		linee=`$gtfcuff match-correct $results/$id.$aa/$algo5.$comp5/gffmul.$algo5.gtf.tmap $total $d1`
		ma=`echo $linea | cut -f 16 -d " "`
		mb=`echo $lineb | cut -f 16 -d " "`
		mc=`echo $linec | cut -f 16 -d " "`
		md=`echo $lined | cut -f 16 -d " "`
		me=`echo $linee | cut -f 16 -d " "`
		m1="$d1 $ma $mb $mc $md $me"
	else
		linea=`$gtfcuff match-correct $results/$id.$aa/$algo1.$comp1/gffmul.$algo1.gtf.tmap $total $e1`
		lineb=`$gtfcuff match-correct $results/$id.$aa/$algo2.$comp2/gffmul.$algo2.gtf.tmap $total $e1`
		linec=`$gtfcuff match-correct $results/$id.$aa/$algo3.$comp3/gffmul.$algo3.gtf.tmap $total $e1`
		lined=`$gtfcuff match-correct $results/$id.$aa/$algo4.$comp4/gffmul.$algo4.gtf.tmap $total $e1`
		linee=`$gtfcuff match-correct $results/$id.$aa/$algo5.$comp5/gffmul.$algo5.gtf.tmap $total $e1`
		ma=`echo $linea | cut -f 16 -d " "`
		mb=`echo $lineb | cut -f 16 -d " "`
		mc=`echo $linec | cut -f 16 -d " "`
		md=`echo $lined | cut -f 16 -d " "`
		me=`echo $linee | cut -f 16 -d " "`
		m1="$e1 $ma $mb $mc $md $me"
	fi

	# adjusted to match precision
	# m1 = #matched-precision #adjusted-correct-transcripts-coral-w/o-ref #adjusted-correct-transcripts-coral-w/-ref #adjusted-correct-transcripts-w/o-coral
	m2=""
	if (( $(echo "$b3 <= $a3" | bc -l) )) && (( $(echo "$c3 <= $a3" | bc -l) )) && (( $(echo "$d3 <= $a3" | bc -l) )) && (( $(echo "$e3 <= $a3" | bc -l) )); then
		linea=`$gtfcuff match-precision $results/$id.$aa/$algo1.$comp1/gffmul.$algo1.gtf.tmap $total $a3`
		lineb=`$gtfcuff match-precision $results/$id.$aa/$algo2.$comp2/gffmul.$algo2.gtf.tmap $total $a3`
		linec=`$gtfcuff match-precision $results/$id.$aa/$algo3.$comp3/gffmul.$algo3.gtf.tmap $total $a3`
		lined=`$gtfcuff match-precision $results/$id.$aa/$algo4.$comp4/gffmul.$algo4.gtf.tmap $total $a3`
		linee=`$gtfcuff match-precision $results/$id.$aa/$algo5.$comp5/gffmul.$algo5.gtf.tmap $total $a3`
		ma=`echo $linea | cut -f 10 -d " "`
		mb=`echo $lineb | cut -f 10 -d " "`
		mc=`echo $linec | cut -f 10 -d " "`
		md=`echo $lined | cut -f 10 -d " "`
		me=`echo $linee | cut -f 10 -d " "`
		m2="$a3 $ma $mb $mc $md $me"
	elif (( $(echo "$a3 <= $b3" | bc -l) )) && (( $(echo "$c3 <= $b3" | bc -l) )) && (( $(echo "$d3 <= $b3" | bc -l) )) && (( $(echo "$e3 <= $b3" | bc -l) )); then
		linea=`$gtfcuff match-precision $results/$id.$aa/$algo1.$comp1/gffmul.$algo1.gtf.tmap $total $b3`
		lineb=`$gtfcuff match-precision $results/$id.$aa/$algo2.$comp2/gffmul.$algo2.gtf.tmap $total $b3`
		linec=`$gtfcuff match-precision $results/$id.$aa/$algo3.$comp3/gffmul.$algo3.gtf.tmap $total $b3`
		lined=`$gtfcuff match-precision $results/$id.$aa/$algo4.$comp4/gffmul.$algo4.gtf.tmap $total $b3`
		linee=`$gtfcuff match-precision $results/$id.$aa/$algo5.$comp5/gffmul.$algo5.gtf.tmap $total $b3`
		ma=`echo $linea | cut -f 10 -d " "`
		mb=`echo $lineb | cut -f 10 -d " "`
		mc=`echo $linec | cut -f 10 -d " "`
		md=`echo $lined | cut -f 10 -d " "`
		me=`echo $linee | cut -f 10 -d " "`
		m2="$a3 $ma $mb $mc $md $me"
	elif (( $(echo "$b3 <= $c3" | bc -l) )) && (( $(echo "$a3 <= $c3" | bc -l) )) && (( $(echo "$d3 <= $c3" | bc -l) )) && (( $(echo "$e3 <= $c3" | bc -l) )); then
		linea=`$gtfcuff match-precision $results/$id.$aa/$algo1.$comp1/gffmul.$algo1.gtf.tmap $total $c3`
		lineb=`$gtfcuff match-precision $results/$id.$aa/$algo2.$comp2/gffmul.$algo2.gtf.tmap $total $c3`
		linec=`$gtfcuff match-precision $results/$id.$aa/$algo3.$comp3/gffmul.$algo3.gtf.tmap $total $c3`
		lined=`$gtfcuff match-precision $results/$id.$aa/$algo4.$comp4/gffmul.$algo4.gtf.tmap $total $c3`
		linee=`$gtfcuff match-precision $results/$id.$aa/$algo5.$comp5/gffmul.$algo5.gtf.tmap $total $c3`
		ma=`echo $linea | cut -f 10 -d " "`
		mb=`echo $lineb | cut -f 10 -d " "`
		mc=`echo $linec | cut -f 10 -d " "`
		md=`echo $lined | cut -f 10 -d " "`
		me=`echo $linee | cut -f 10 -d " "`
		m2="$a3 $ma $mb $mc $md $me"
	elif (( $(echo "$b3 <= $d3" | bc -l) )) && (( $(echo "$c3 <= $d3" | bc -l) )) && (( $(echo "$a3 <= $d3" | bc -l) )) && (( $(echo "$e3 <= $d3" | bc -l) )); then
		linea=`$gtfcuff match-precision $results/$id.$aa/$algo1.$comp1/gffmul.$algo1.gtf.tmap $total $d3`
		lineb=`$gtfcuff match-precision $results/$id.$aa/$algo2.$comp2/gffmul.$algo2.gtf.tmap $total $d3`
		linec=`$gtfcuff match-precision $results/$id.$aa/$algo3.$comp3/gffmul.$algo3.gtf.tmap $total $d3`
		lined=`$gtfcuff match-precision $results/$id.$aa/$algo4.$comp4/gffmul.$algo4.gtf.tmap $total $d3`
		linee=`$gtfcuff match-precision $results/$id.$aa/$algo5.$comp5/gffmul.$algo5.gtf.tmap $total $d3`
		ma=`echo $linea | cut -f 10 -d " "`
		mb=`echo $lineb | cut -f 10 -d " "`
		mc=`echo $linec | cut -f 10 -d " "`
		md=`echo $lined | cut -f 10 -d " "`
		me=`echo $linee | cut -f 10 -d " "`
		m2="$a3 $ma $mb $mc $md $me"
	else
		linea=`$gtfcuff match-precision $results/$id.$aa/$algo1.$comp1/gffmul.$algo1.gtf.tmap $total $e3`
		lineb=`$gtfcuff match-precision $results/$id.$aa/$algo2.$comp2/gffmul.$algo2.gtf.tmap $total $e3`
		linec=`$gtfcuff match-precision $results/$id.$aa/$algo3.$comp3/gffmul.$algo3.gtf.tmap $total $e3`
		lined=`$gtfcuff match-precision $results/$id.$aa/$algo4.$comp4/gffmul.$algo4.gtf.tmap $total $e3`
		linee=`$gtfcuff match-precision $results/$id.$aa/$algo5.$comp5/gffmul.$algo5.gtf.tmap $total $e3`
		ma=`echo $linea | cut -f 10 -d " "`
		mb=`echo $lineb | cut -f 10 -d " "`
		mc=`echo $linec | cut -f 10 -d " "`
		md=`echo $lined | cut -f 10 -d " "`
		me=`echo $linee | cut -f 10 -d " "`
		m2="$a3 $ma $mb $mc $md $me"
	fi

	echo $id $aa $total $a0 $a1 $a2 $a3 $b0 $b1 $b2 $b3 $c0 $c1 $c2 $c3 $d0 $d1 $d2 $d3 $e0 $e1 $e2 $e3 $m1 $m2
done
