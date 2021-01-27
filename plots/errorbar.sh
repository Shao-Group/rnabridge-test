#!/bin/bash

outdir=$1
outputfile=$2
dir=$outdir/..
margin=$3

cd $outdir

tmpfile=tmpfile.R

## raw
id="raw-correct"
texfile=$outdir/$id.tex
echo "source(\"$dir/errorbar.R\")" > $tmpfile
echo "plot.error.bar(\"$outputfile\", \"$texfile\", 2, 4, 6, \"Original Correct\", $margin, 1)" >> $tmpfile
R CMD BATCH $tmpfile
rm -rf $tmpfile
$dir/wrap.sh $id.tex
pdflatex $id.tex

id="raw-precision"
texfile=$outdir/$id.tex
echo "source(\"$dir/errorbar.R\")" > $tmpfile
echo "plot.error.bar(\"$outputfile\", \"$texfile\", 8, 10, 12, \"Original Precision\", $margin, 0)" >> $tmpfile
R CMD BATCH $tmpfile
rm -rf $tmpfile
$dir/wrap.sh $id.tex
pdflatex $id.tex

id="raw"
cp $dir/combine1.tex $id.tex
sed -i "" "s/AAA/${id}-correct/" $id.tex
sed -i "" "s/BBB/${id}-precision/" $id.tex
pdflatex $id.tex

## adjust
id="adjust-correct"
texfile=$outdir/$id.tex
echo "source(\"$dir/errorbar.R\")" > $tmpfile
echo "plot.error.bar(\"$outputfile\", \"$texfile\", 20, 22, 24, \"Adjusted Correct\", $margin, 1)" >> $tmpfile
R CMD BATCH $tmpfile
rm -rf $tmpfile
$dir/wrap.sh $id.tex
pdflatex $id.tex

id="adjust-precision"
texfile=$outdir/$id.tex
echo "source(\"$dir/errorbar.R\")" > $tmpfile
echo "plot.error.bar(\"$outputfile\", \"$texfile\", 14, 16, 18, \"Adjusted Precision\", $margin, 0)" >> $tmpfile
R CMD BATCH $tmpfile
rm -rf $tmpfile
$dir/wrap.sh $id.tex
pdflatex $id.tex

id="adjust"
cp $dir/combine1.tex $id.tex
sed -i "" "s/AAA/${id}-correct/" $id.tex
sed -i "" "s/BBB/${id}-precision/" $id.tex
pdflatex $id.tex
