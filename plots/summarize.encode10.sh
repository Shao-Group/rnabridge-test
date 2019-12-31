#!/bin/bash

dir=`pwd`
outputfile=$dir/results.$1/summary.encode10
rm -rf $outputfile
	
cd $outdir

for gtf in `echo "000"`
do

for xxx in `echo "0 A"`
do

for aaa in `echo "stringtie scallop"`
do

for bbb in `echo "star hisat"`
do

if [ "$gtf" == "gtf" ] && [ "$bbb" == "hisat" ]; then
	continue
fi

datafile=$dir/results.$1/encode10-$gtf-$aaa-$bbb-$xxx

tmpfile=$dir/tmpfile.R
rm -rf $tmpfile

echo "source(\"$dir/summarize.R\")" > $tmpfile
echo "summarize(\"$datafile\", \"$outputfile\")" >> $tmpfile
R CMD BATCH $tmpfile
rm -rf $tmpfile

done
done
done
done

cat $outputfile | sed 's/.U.*000-//g' | sed 's/  */ /g' | sed 's/-0//g' | sed 's/-A//g' | sed 's/-/ /g' | sed 's/ / \& /g' | sed 's/\& $/\\\\/g' | sed 's/stringtie/StringTie/g' | sed 's/star/STAR/g' | sed 's/scallop/Scallop/g' | sed 's/hisat/HISAT/g' | sed 's/^/w\/o ref. \& /g' | column -t
