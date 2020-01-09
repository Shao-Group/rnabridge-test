#!/bin/bash

outdir=$1
datafile=$2
prefix=$3
dir=$outdir/..

mkdir -p $outdir
cd $outdir

# draw precision
id="$prefix-precision"
texfile=$outdir/$id.tex
tmpfile=$dir/tmpfile.R
rm -rf $tmpfile

echo "source(\"$dir/hist.R\")" > $tmpfile
echo "hist.2(\"$datafile\", \"$texfile\", $4, $5, \"Coral $8 ref.\", \"w/o Coral\", \"$9 Precision\", 1)" >> $tmpfile
R CMD BATCH $tmpfile
$dir/wrap.sh $id.tex
pdflatex $id.tex

# draw correct
id="$prefix-correct"
texfile=$outdir/$id.tex
tmpfile=$dir/tmpfile.R
rm -rf $tmpfile

echo "source(\"$dir/hist.R\")" > $tmpfile
echo "hist.2(\"$datafile\", \"$texfile\", $6, $7, \"Coral $8 ref.\", \"w/o Coral\", \"$9 Precision\", 1)" >> $tmpfile
R CMD BATCH $tmpfile
$dir/wrap.sh $id.tex
pdflatex $id.tex

id="$prefix"
cp $dir/combine.tex $id.tex
sed -i "" "s/AAA/${id}-precision/" $id.tex
sed -i "" "s/BBB/${id}-correct/" $id.tex
pdflatex $id.tex

rm -rf $tmpfile
