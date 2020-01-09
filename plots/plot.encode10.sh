#!/bin/bash

dir=`pwd`
outdir=$dir/encode10.$1
tmpoutfile=$outdir/tmpoutfile.data
mkdir -p $outdir
rm -rf $tmpoutfile
	
cd $outdir

for gtf in `echo "000"`
do

for aaa in `echo "stringtie scallop"`
do

for bbb in `echo "star hisat"`
do

if [ "$gtf" == "gtf" ] && [ "$bbb" == "hisat" ]; then
	continue
fi

rawdata=$dir/results.$1/encode10-$gtf-$aaa-$bbb

prefix=normal-$gtf-$aaa-$bbb
$dir/barplot.sh $outdir $rawdata $prefix 15 11 7 13 9 5 Original

prefix=adjust-$gtf-$aaa-$bbb
$dir/barplot.sh $outdir $rawdata $prefix 19 18 17 23 22 21 Adjusted

tmpfile=$dir/tmpfile.R
rm -rf $tmpfile
echo "source(\"$dir/summarize.R\")" > $tmpfile
echo "summarize.3(\"$rawdata\", \"$tmpoutfile\")" >> $tmpfile
R CMD BATCH $tmpfile
rm -rf $tmpfile

done
done
done


outputfile=$outdir/summary.encode10
cat $tmpoutfile | sed 's/.U.*000-//g' | sed 's/  */ /g' | sed 's/-/,/g' | sed 's/,0/,WO/g' | sed 's/,A/,WR/g' | sed 's/stringtie/ST/g' | sed 's/star/SR/g' | sed 's/scallop/SC/g' | sed 's/hisat/HI/g'  > $outputfile

$dir/errorbar.sh $outdir $outputfile 0.5
rm -rf $tmpoutfile
