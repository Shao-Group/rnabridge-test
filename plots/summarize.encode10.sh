#!/bin/bash

dir=`pwd`
outdir=$dir/encode10.$1.summary
mkdir -p $outdir

outputfile=$outdir/summary.encode10
tmpoutfile=$dir/tmpfile.data
rm -rf $tmpoutfile
	
cd $outdir

for gtf in `echo "000"`
do

for xxx in `echo "0 A"`
do

for aaa in `echo "stringtie scallop"`
do

for bbb in `echo "star hisat"`
do

if [ "$gtf" == "gtf" ] && [ "$bbb" == "hisat" ]; then
	continue
fi

datafile=$dir/results.$1/encode10-$gtf-$aaa-$bbb-$xxx

tmpfile=$dir/tmpfile.R
rm -rf $tmpfile

echo "source(\"$dir/summarize.R\")" > $tmpfile
echo "summarize(\"$datafile\", \"$tmpoutfile\")" >> $tmpfile
R CMD BATCH $tmpfile
rm -rf $tmpfile

done
done
done
done

cat $tmpoutfile | sed 's/.U.*000-//g' | sed 's/  */ /g' | sed 's/-/,/g' | sed 's/,0/,WO/g' | sed 's/,A/,WR/g' | sed 's/stringtie/ST/g' | sed 's/star/SR/g' | sed 's/scallop/SC/g' | sed 's/hisat/HI/g'  > $outputfile
cat $outputfile | cut -f 1 -d " " | cut -f 3 -d "," > file1
cat $outputfile | cut -f 1 -d " " | cut -f 1-2 -d "," > file2
cat $outputfile | cut -f 2-20 -d " " > file3
paste -d "," file1 file2 > file12
paste -d " " file12 file3 > $outputfile

#cat $outputfile | sed 's/.U.*000-//g' | sed 's/  */ /g' | sed 's/-0//g' | sed 's/-A//g' | sed 's/-/ /g' | sed 's/ / \& /g' | sed 's/\& $/\\\\/g' | sed 's/stringtie/StringTie/g' | sed 's/star/STAR/g' | sed 's/scallop/Scallop/g' | sed 's/hisat/HISAT/g' | sed 's/^/w\/o ref. \& /g' | column -t

# draw figures

cd $outdir

## raw

id="raw-correct"
texfile=$outdir/$id.tex
echo "source(\"$dir/errorbar.R\")" > $tmpfile
echo "plot.error.bar(\"$outputfile\", \"$texfile\", 4, 2, 5, 3, \"Raw Correct\", 0.7, 1)" >> $tmpfile
R CMD BATCH $tmpfile
rm -rf $tmpfile
$dir/wrap.sh $id.tex
pdflatex $id.tex

id="raw-precision"
texfile=$outdir/$id.tex
echo "source(\"$dir/errorbar.R\")" > $tmpfile
echo "plot.error.bar(\"$outputfile\", \"$texfile\", 8, 6, 9, 7, \"Raw Precision\", 0.7, 0)" >> $tmpfile
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
echo "plot.error.bar(\"$outputfile\", \"$texfile\", 12, 10, 13, 11, \"Adjusted Correct\", 0.7, 1)" >> $tmpfile
R CMD BATCH $tmpfile
rm -rf $tmpfile
$dir/wrap.sh $id.tex
pdflatex $id.tex

id="adjust-precision"
texfile=$outdir/$id.tex
echo "source(\"$dir/errorbar.R\")" > $tmpfile
echo "plot.error.bar(\"$outputfile\", \"$texfile\", 16, 14, 17, 15, \"Adjusted Precision\", 0.7, 0)" >> $tmpfile
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
