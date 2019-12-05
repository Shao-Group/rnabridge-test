#!/bin/bash

dir=`pwd`
outdir=$dir/encode65
mkdir -p $outdir
	
cd $outdir


for aaa in `echo "scallop stringtie"`
do

datafile=$dir/results.D131/encode65-$aaa

# draw precision
id="$aaa-precision"
texfile=$outdir/$id.tex

tmpfile=$dir/tmpfile.R
rm -rf $tmpfile

echo "source(\"$dir/R/barplot.adjusted.R\")" > $tmpfile
echo "plot.precision(\"$datafile\", \"$texfile\", \"$aaa\", \"Coral+$aaa\")" >> $tmpfile
R CMD BATCH $tmpfile
$dir/wrap.sh $id.tex
pdflatex $id.tex


# draw recall
id="$aaa-correct"
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
