#!/bin/bash

dir=`pwd`
outdir=$dir/gtex.$1
tmpoutfile=$outdir/tmpoutfile.data
mkdir -p $outdir
rm -rf $tmpoutfile
	
cd $outdir

for aaa in `echo "stringtie scallop"`
do

rawdata=$dir/results.$1/gtex-$aaa

prefix=normal-$aaa-A
$dir/hist.sh $outdir $rawdata $prefix 15 7 13 5 "w/" Original

prefix=normal-$aaa-0
$dir/hist.sh $outdir $rawdata $prefix 11 7 9 5 "w/o" Original

prefix=adjust-$aaa-A
$dir/hist.sh $outdir $rawdata $prefix 19 17 23 21 "w/" Adjusted

prefix=adjust-$aaa-0
$dir/hist.sh $outdir $rawdata $prefix 18 17 22 21 "w/o" Adjusted

tmpfile=$dir/tmpfile.R
rm -rf $tmpfile
echo "source(\"$dir/summarize.R\")" > $tmpfile
echo "summarize.3(\"$rawdata\", \"$tmpoutfile\")" >> $tmpfile
R CMD BATCH $tmpfile
rm -rf $tmpfile

done

outputfile=$outdir/summary.gtex
cat $tmpoutfile | sed 's/.U.*gtex-//g' | sed 's/  */ /g' | sed 's/-/,/g' | sed 's/,0/,WO/g' | sed 's/,A/,WR/g' | sed 's/stringtie/ST/g' | sed 's/star/SR/g' | sed 's/scallop/SC/g' | sed 's/hisat/HI/g'  > $outputfile

$dir/errorbar.sh $outdir $outputfile 0.3
