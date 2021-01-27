#!/bin/bash

outdir=$1
rawdata=$2
prefix=$3
way5=${15}
dir=$outdir/..

mkdir -p $outdir
cd $outdir

# draw precision first half
id="$prefix-precision"
texfile=$outdir/$id.tex

tmpfile=$dir/tmpfile.R
datafile=$dir/tmpfile.data

cat $rawdata | sort -k${5},${5}n | sed 's/ENC//g' > $datafile
rm -rf $tmpfile

echo "source(\"$dir/barplot.R\")" > $tmpfile

if [ "$way5" = "1" ]; then
	echo "plot.mean.5(\"$datafile\", \"$texfile\", $4, $5, $6, $7, $8, \"${14} Precision\", 1)" >> $tmpfile
else
	echo "plot.horiz.3(\"$datafile\", \"$texfile\", $4, $5, $6, \"${10} Precision\", 1)" >> $tmpfile
fi

R CMD BATCH $tmpfile
$dir/wrap.sh $id.tex
pdflatex $id.tex

# draw recall
id="$prefix-correct"
texfile=$outdir/$id.tex

tmpfile=$dir/tmpfile.R
rm -rf $tmpfile

echo "source(\"$dir/barplot.R\")" > $tmpfile
if [ "$way5" = "1" ]; then
	echo "plot.mean.5(\"$datafile\", \"$texfile\", $9, ${10}, ${11}, ${12}, ${13}, \"${14} Correct\", 1)" >> $tmpfile
else
	echo "plot.horiz.3(\"$datafile\", \"$texfile\", $7, $8, $9, \"${10} Correct\", -1)" >> $tmpfile
fi

R CMD BATCH $tmpfile
$dir/wrap.sh $id.tex
pdflatex $id.tex

id=$prefix
cp $dir/combine1.tex $id.tex
sed -i "" "s/AAA/${id}-precision/" $id.tex
sed -i "" "s/BBB/${id}-correct/" $id.tex
pdflatex $id.tex

rm -rf $tmpfile $datafile
