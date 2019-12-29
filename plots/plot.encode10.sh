#!/bin/bash

dir=`pwd`
outdir=$dir/encode10.$1.$2
mkdir -p $outdir
	
cd $outdir

for gtf in `echo "000 gtf"`
do

for aaa in `echo "scallop stringtie"`
do

for bbb in `echo "star hisat"`
do

for xxx in `echo "0 A"`
do

if [ "$gtf" == "gtf" ] && [ "$bbb" == "hisat" ]; then
	continue
fi

rawdata=$dir/results.$1/encode10-$gtf-$aaa-$bbb-$xxx

# draw precision
id="$gtf-$aaa-$bbb-$xxx-precision"
texfile=$outdir/$id.tex

tmpfile=$dir/tmpfile.R
datafile=$dir/tmpfile.data
cat $rawdata | sort -k${4},${4}n > $datafile

rm -rf $tmpfile

echo "source(\"$dir/R/barplot.adjusted.R\")" > $tmpfile
echo "plot.precision.horiz(\"$datafile\", \"$texfile\", $3, $4, \"$aaa\", \"Coral+$aaa\", \"$7 Precision\", 1)" >> $tmpfile
R CMD BATCH $tmpfile
$dir/wrap.sh $id.tex
pdflatex $id.tex


# draw recall
id="$gtf-$aaa-$bbb-$xxx-correct"
texfile=$outdir/$id.tex

tmpfile=$dir/tmpfile.R
#cat $rawdata | sort -k${6},${6}n > $datafile

rm -rf $tmpfile

echo "source(\"$dir/R/barplot.adjusted.R\")" > $tmpfile
echo "plot.correct.horiz(\"$datafile\", \"$texfile\", $5, $6, \"$aaa\", \"Coral+$aaa\", \"$7 Correct\", -1)" >> $tmpfile
R CMD BATCH $tmpfile
$dir/wrap.sh $id.tex
pdflatex $id.tex

id="$gtf-$aaa-$bbb-$xxx"
cp $dir/R/combine.tex $id.tex
sed -i "" "s/AAA/${id}-precision/" $id.tex
sed -i "" "s/BBB/${id}-correct/" $id.tex
pdflatex $id.tex

rm -rf $tmpfile $datafile

done
done
done
done
