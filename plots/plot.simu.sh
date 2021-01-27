#!/bin/bash

dir=`pwd`
outdir=$dir/simu.$1
tmpoutfile=$outdir/tmpoutfile.data
mkdir -p $outdir
rm -rf $tmpoutfile
	
cd $outdir

for gtf in `echo "gtf0 gtf3"`
do

for rlen in `echo "75r 100r"`
do

for flen in `echo "300f 500f"`
do

for aaa in `echo "scallop stringtie"`
do

rawdata=$dir/results.$1/simu-$gtf-$rlen-$flen-$aaa

##prefix=normal-$gtf-$rlen-$flen-$aaa-A
##$dir/hist.sh $outdir $rawdata $prefix 15 7 13 5 "w/" Original
##
##prefix=normal-$gtf-$rlen-$flen-$aaa-0
##$dir/hist.sh $outdir $rawdata $prefix 11 7 9 5 "w/o" Original
##
##prefix=adust-$gtf-$rlen-$flen-$aaa-A
##$dir/hist.sh $outdir $rawdata $prefix 19 17 23 21 "w/" Adjusted
##
##prefix=adust-$gtf-$rlen-$flen-$aaa-0
##$dir/hist.sh $outdir $rawdata $prefix 18 17 22 21 "w/o" Adjusted

tmpfile=$dir/tmpfile.R
rm -rf $tmpfile
echo "source(\"$dir/summarize.R\")" > $tmpfile
echo "summarize.3(\"$rawdata\", \"$tmpoutfile\")" >> $tmpfile
R CMD BATCH $tmpfile
rm -rf $tmpfile

done
done
done
done

outputfile=$outdir/summary.simu
cat $tmpoutfile | sed 's/.U.*simu,//g' | sed 's/  */ /g' | sed 's/-/,/g' | sed 's/,0/,WO/g' | sed 's/,A/,WR/g' | sed 's/stringtie/ST/g' | sed 's/star/SR/g' | sed 's/scallop/SC/g' | sed 's/hisat/HI/g'  > $outputfile

$dir/errorbar.sh $outdir $outputfile 1.5
