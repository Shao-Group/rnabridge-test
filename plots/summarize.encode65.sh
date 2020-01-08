#!/bin/bash

dir=`pwd`
outdir=$dir/encode65.$1.summary
mkdir -p $outdir

outputfile=$outdir/summary.encode65
tmpoutfile=$dir/tmpfile.data
rm -rf $outputfile
rm -rf $tmpoutfile
	
cd $outdir

for aaa in `echo "stringtie scallop"`
do

if [ "$gtf" == "gtf" ] && [ "$bbb" == "hisat" ]; then
	continue
fi

datafile=$dir/results.$1/encode65-$aaa

tmpfile=$dir/tmpfile.R
rm -rf $tmpfile

echo "source(\"$dir/summarize.R\")" > $tmpfile
echo "summarize.3(\"$datafile\", \"$tmpoutfile\")" >> $tmpfile
R CMD BATCH $tmpfile
rm -rf $tmpfile

done

cat $tmpoutfile | sed 's/.U.*000-//g' | sed 's/  */ /g' | sed 's/-/,/g' | sed 's/,0/,WO/g' | sed 's/,A/,WR/g' | sed 's/stringtie/ST/g' | sed 's/star/SR/g' | sed 's/scallop/SC/g' | sed 's/hisat/HI/g'  > $outputfile
#cat $outputfile | cut -f 1 -d " " | cut -f 1 -d "," > file1
#cat $outputfile | cut -f 1 -d " " | cut -f 1 -d "," > file2
#cat $outputfile | cut -f 2-100 -d " " > file3
#paste -d "," file1 file2 > file12
#paste -d " " file12 file3 > $outputfile
#rm -rf file1 file2 file3 file12 $tmpoutfile

## raw

id="raw-correct"
texfile=$outdir/$id.tex
echo "source(\"$dir/errorbar.R\")" > $tmpfile
echo "plot.error.bar(\"$outputfile\", \"$texfile\", 2, 4, 6, \"Raw Correct\", 0.7, 1)" >> $tmpfile
R CMD BATCH $tmpfile
rm -rf $tmpfile
$dir/wrap.sh $id.tex
pdflatex $id.tex

id="raw-precision"
texfile=$outdir/$id.tex
echo "source(\"$dir/errorbar.R\")" > $tmpfile
echo "plot.error.bar(\"$outputfile\", \"$texfile\", 8, 10, 12, \"Raw Precision\", 0.7, 0)" >> $tmpfile
R CMD BATCH $tmpfile
rm -rf $tmpfile
$dir/wrap.sh $id.tex
pdflatex $id.tex

id="raw"
cp $dir/combine.tex $id.tex
sed -i "" "s/AAA/${id}-correct/" $id.tex
sed -i "" "s/BBB/${id}-precision/" $id.tex
pdflatex $id.tex

## adjust

id="adjust-correct"
texfile=$outdir/$id.tex
echo "source(\"$dir/errorbar.R\")" > $tmpfile
echo "plot.error.bar(\"$outputfile\", \"$texfile\", 20, 22, 24, \"Adjusted Correct\", 0.7, 1)" >> $tmpfile
R CMD BATCH $tmpfile
rm -rf $tmpfile
$dir/wrap.sh $id.tex
pdflatex $id.tex

id="adjust-precision"
texfile=$outdir/$id.tex
echo "source(\"$dir/errorbar.R\")" > $tmpfile
echo "plot.error.bar(\"$outputfile\", \"$texfile\", 14, 16, 18, \"Adjusted Precision\", 0.7, 0)" >> $tmpfile
R CMD BATCH $tmpfile
rm -rf $tmpfile
$dir/wrap.sh $id.tex
pdflatex $id.tex

id="adjust"
cp $dir/combine.tex $id.tex
sed -i "" "s/AAA/${id}-correct/" $id.tex
sed -i "" "s/BBB/${id}-precision/" $id.tex
pdflatex $id.tex


rm -rf file1 file2 file3 file12 $tmpoutfile
