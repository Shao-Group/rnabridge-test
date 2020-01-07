#!/bin/bash

dir=`pwd`
outputfile=$dir/results.$1/summary.encode65
rm -rf $outputfile
	
cd $outdir

for xxx in `echo "0 A"`
do

for aaa in `echo "stringtie scallop"`
do

if [ "$gtf" == "gtf" ] && [ "$bbb" == "hisat" ]; then
	continue
fi

datafile=$dir/results.$1/encode65-$aaa-$xxx

tmpfile=$dir/tmpfile.R
rm -rf $tmpfile

echo "source(\"$dir/summarize.R\")" > $tmpfile
echo "summarize(\"$datafile\", \"$outputfile\")" >> $tmpfile
R CMD BATCH $tmpfile
rm -rf $tmpfile

done
done

cat $outputfile

cat $outputfile | sed 's/.U.*encode65//g' | sed 's/  */ /g' | sed 's/-0//g' | sed 's/-A//g' | sed 's/-/ /g' | sed 's/ / \& /g' | sed 's/\& $/\\\\/g' | sed 's/stringtie/StringTie/g' | sed 's/star/STAR/g' | sed 's/scallop/Scallop/g' | sed 's/hisat/HISAT/g' | sed 's/^/w\/o ref. \& /g' | column -t
