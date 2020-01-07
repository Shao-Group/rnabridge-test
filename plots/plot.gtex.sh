#!/bin/bash

dir=`pwd`
outdir=$dir/gtex.$1.$2
mkdir -p $outdir
	
cd $outdir

for aaa in `echo "scallop stringtie"`
do

for xxx in `echo "0"`
do

datafile=$dir/results.$1/gtex-$aaa-$xxx

# draw precision
id="$aaa-$xxx-precision"
texfile=$outdir/$id.tex
tmpfile=$dir/tmpfile.R
rm -rf $tmpfile

echo "source(\"$dir/hist.R\")" > $tmpfile
echo "hist.precision(\"$datafile\", \"$texfile\", $3, $4, \"$aaa\", \"Coral+$aaa\", \"$7 Precision\", 1)" >> $tmpfile
R CMD BATCH $tmpfile
$dir/wrap.sh $id.tex
pdflatex $id.tex


# draw correct
id="$aaa-$xxx-correct"
texfile=$outdir/$id.tex
tmpfile=$dir/tmpfile.R
rm -rf $tmpfile

echo "source(\"$dir/hist.R\")" > $tmpfile
echo "hist.correct(\"$datafile\", \"$texfile\", $5, $6, \"$aaa\", \"Coral+$aaa\", \"$7 Correct\", 1)" >> $tmpfile
R CMD BATCH $tmpfile
$dir/wrap.sh $id.tex
pdflatex $id.tex

id="$aaa-$xxx"
cp $dir/combine.tex $id.tex
sed -i "" "s/AAA/${id}-precision/" $id.tex
sed -i "" "s/BBB/${id}-correct/" $id.tex
pdflatex $id.tex

rm -rf $tmpfile

done
done
