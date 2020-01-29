#!/bin/bash

dir=`pwd`
outdir=$dir/encode65.$1
tmpoutfile=$outdir/tmpoutfile.data
mkdir -p $outdir
rm -rf $tmpoutfile
	
cd $outdir

for aaa in `echo "stringtie scallop"`
do

rawdata=$dir/results.$1/encode65-$aaa
rawdata1=$dir/results.$1/encode65-$aaa-1
rawdata2=$dir/results.$1/encode65-$aaa-2

cat $rawdata | head -n 25 > $rawdata1
cat $rawdata | tail -n 25 > $rawdata2

prefix=normal-$aaa-1
$dir/barplot.sh $outdir $rawdata1 $prefix 15 11 7 13 9 5 Original

prefix=adjust-$aaa-1
$dir/barplot.sh $outdir $rawdata1 $prefix 19 18 17 23 22 21 Adjusted

prefix=normal-$aaa-2
$dir/barplot.sh $outdir $rawdata2 $prefix 15 11 7 13 9 5 Original

prefix=adjust-$aaa-2
$dir/barplot.sh $outdir $rawdata2 $prefix 19 18 17 23 22 21 Adjusted

tmpfile=$dir/tmpfile.R
rm -rf $tmpfile
echo "source(\"$dir/summarize.R\")" > $tmpfile
echo "summarize.3(\"$rawdata\", \"$tmpoutfile\")" >> $tmpfile
R CMD BATCH $tmpfile
rm -rf $tmpfile

done

outputfile=$outdir/summary.encode65
cat $tmpoutfile | sed 's/.U.*encode65-//g' | sed 's/  */ /g' | sed 's/-/,/g' | sed 's/,0/,WO/g' | sed 's/,A/,WR/g' | sed 's/stringtie/ST/g' | sed 's/star/SR/g' | sed 's/scallop/SC/g' | sed 's/hisat/HI/g'  > $outputfile
$dir/errorbar.sh $outdir $outputfile 0.23
