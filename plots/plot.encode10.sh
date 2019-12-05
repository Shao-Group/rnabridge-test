#!/bin/bash

dir=`pwd`
outdir=$dir/encode10
mkdir -p $outdir
	
cd $outdir


for aaa in `echo "scallop stringtie"`
do

for bbb in `echo "star hisat"`
do

datafile=$dir/results.D131/encode10-$aaa-$bbb

# draw precision
id="$aaa-$bbb-precision"
texfile=$outdir/$id.tex

tmpfile=$dir/tmpfile.R
rm -rf $tmpfile

echo "source(\"$dir/R/barplot.adjusted.R\")" > $tmpfile
echo "plot.precision(\"$datafile\", \"$texfile\", \"$aaa\", \"Coral+$aaa\")" >> $tmpfile
R CMD BATCH $tmpfile
$dir/wrap.sh $id.tex
pdflatex $id.tex


# draw recall
id="$aaa-$bbb-correct"
texfile=$outdir/$id.tex

tmpfile=$dir/tmpfile.R
rm -rf $tmpfile

echo "source(\"$dir/R/barplot.adjusted.R\")" > $tmpfile
echo "plot.correct(\"$datafile\", \"$texfile\", \"$aaa\", \"Coral+$aaa\")" >> $tmpfile
R CMD BATCH $tmpfile
$dir/wrap.sh $id.tex
pdflatex $id.tex

rm -rf $tmpfile

done
done
