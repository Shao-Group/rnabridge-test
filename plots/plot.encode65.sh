#!/bin/bash

dir=`pwd`
outdir=$dir/encode65.$1.$2
mkdir -p $outdir
	
cd $outdir

for aaa in `echo "scallop stringtie"`
do

rawdata=$dir/results.$1/encode65-$aaa

# draw precision first half
id="$aaa-precision"
texfile=$outdir/$id.tex

tmpfile=$dir/tmpfile.R
datafile=$dir/tmpfile.data

cat $rawdata | sort -k${4},${4}n | sed 's/ENC//g' > $datafile
mvalue=`cat $datafile | tail -n 1 | cut -f 13 -d " "`
rm -rf $tmpfile

echo "source(\"$dir/barplot.R\")" > $tmpfile
echo "plot.horiz.3(\"$datafile\", \"$texfile\", $3, $4, $5, \"$9 Precision\", 1)" >> $tmpfile
R CMD BATCH $tmpfile
$dir/wrap.sh $id.tex
pdflatex $id.tex

# draw recall
id="$aaa-correct"
texfile=$outdir/$id.tex

tmpfile=$dir/tmpfile.R
mvalue=`cat $datafile | tail -n 1 | cut -f 16 -d " "`
rm -rf $tmpfile

echo "source(\"$dir/barplot.R\")" > $tmpfile
echo "plot.horiz.3(\"$datafile\", \"$texfile\", $6, $7, $8, \"$9 Correct\", -1)" >> $tmpfile
R CMD BATCH $tmpfile
$dir/wrap.sh $id.tex
pdflatex $id.tex

id="$aaa"
cp $dir/combine.tex $id.tex
sed -i "" "s/AAA/${id}-precision/" $id.tex
sed -i "" "s/BBB/${id}-correct/" $id.tex
pdflatex $id.tex

rm -rf $tmpfile $datafile

done
