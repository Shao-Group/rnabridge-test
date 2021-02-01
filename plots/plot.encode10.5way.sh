#!/bin/bash

dir=`pwd`
outdir=$dir/encode10.4way.$1
tmpoutfile=$outdir/tmpoutfile.data
mkdir -p $outdir
rm -rf $tmpoutfile
	
cd $outdir


for aligner in `echo "star hisat"`
do

rawdata=$dir/results.$1/encode10.5way.$aligner

#prefix=normal
#$dir/barplot.sh $outdir $rawdata $prefix 23 19 15 11 7 21 17 13 9 5 Original 1

#prefix=adjust
#$dir/barplot.sh $outdir $rawdata $prefix 29 28 27 26 25 35 34 33 32 31 Adjusted 1

tmpfile=$dir/tmpfile.R
rm -rf $tmpfile
echo "source(\"$dir/summarize.R\")" > $tmpfile
echo "summarize.5(\"$rawdata\", \"$tmpoutfile\", \"$aligner\")" >> $tmpfile
R CMD BATCH $tmpfile
rm -rf $tmpfile

done

outputfile=$outdir/summary.encode10
cat $tmpoutfile | sed 's/.U.*000-//g' | sed 's/  */ /g' | sed 's/-/,/g' | sed 's/,0/,WO/g' | sed 's/,A/,WR/g' | sed 's/stringtie/ST/g' | sed 's/star/STAR/g' | sed 's/scallop/SC/g' | sed 's/hisat/HISAT2/g'  > $outputfile

#prefix=normal
#$dir/barplot.sh $outdir $outputfile $prefix 23 19 15 11 7 21 17 13 9 5 Original 1

prefix=adjust
$dir/barplot.sh $outdir $outputfile $prefix 29 28 27 26 25 35 34 33 32 31 Adjusted 1

#rm -rf $tmpoutfile
