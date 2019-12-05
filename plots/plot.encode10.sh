#!/bin/bash

dir=`pwd`
datafile=$dir/results.D131/encode10-scallop-star
outdir=$dir/encode10
mkdir -p $outdir
	
cd $outdir


# draw precision
id="scallop-star-precision"
texfile=$outdir/$id.tex

tmpfile=$dir/tmpfile.R
rm -rf $tmpfile

echo "source(\"$dir/R/barplot.adjusted.R\")" > $tmpfile
echo "plot.precision(\"$datafile\", \"$texfile\", 50, 8, 50, \"Scallop\", \"Coral+Scallop\")" >> $tmpfile
R CMD BATCH $tmpfile
$dir/wrap.sh $id.tex
pdflatex $id.tex


# draw recall
id="scallop-star-correct"
texfile=$outdir/$id.tex

tmpfile=$dir/tmpfile.R
rm -rf $tmpfile

echo "source(\"$dir/R/barplot.adjusted.R\")" > $tmpfile
echo "plot.correct(\"$datafile\", \"$texfile\", 22000, 8, 22000, \"Scallop\", \"Coral+Scallop\")" >> $tmpfile
R CMD BATCH $tmpfile
$dir/wrap.sh $id.tex
pdflatex $id.tex

rm -rf $tmpfile
