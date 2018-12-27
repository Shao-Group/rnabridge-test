#!/bin/bash

list=../data/encode10.list
#summary=./encode10/collect.B759

summary=./encode10/collect.A021
mkdir -p $summary

# collect multi-exon results with default parameters
rm -rf $summary/multi.star.stringtie
rm -rf $summary/multi.star.scallop
rm -rf $summary/multi.hisat.stringtie
rm -rf $summary/multi.hisat.scallop

rm -rf $summary/match.correct.star.stringtie
rm -rf $summary/match.correct.star.scallop
rm -rf $summary/match.correct.hisat.stringtie
rm -rf $summary/match.correct.hisat.scallop

rm -rf $summary/match.precision.star.stringtie
rm -rf $summary/match.precision.star.scallop
rm -rf $summary/match.precision.hisat.stringtie
rm -rf $summary/match.precision.hisat.scallop


for x in `cat $list | head -n 10`
do
	id=`echo $x | cut -f 1 -d ":"`
	./collect.encode10.multi.sh $id star stringtie.default stringtie.A021 >> $summary/multi.star.stringtie
	./collect.encode10.multi.sh $id star scallop.default scallop.A021 >> $summary/multi.star.scallop
	./collect.encode10.multi.sh $id hisat stringtie.default stringtie.A021 >> $summary/multi.hisat.stringtie
	./collect.encode10.multi.sh $id hisat scallop.default scallop.A021 >> $summary/multi.hisat.scallop

	./match.correct.sh $id star stringtie default A021 >> $summary/match.correct.star.stringtie
	./match.correct.sh $id star scallop default A021 >> $summary/match.correct.star.scallop
	./match.correct.sh $id hisat stringtie default A021 >> $summary/match.correct.hisat.stringtie
	./match.correct.sh $id hisat scallop default A021 >> $summary/match.correct.hisat.scallop

	./match.precision.sh $id star stringtie default A021 >> $summary/match.precision.star.stringtie
	./match.precision.sh $id star scallop default A021 >> $summary/match.precision.star.scallop
	./match.precision.sh $id hisat stringtie default A021 >> $summary/match.precision.hisat.stringtie
	./match.precision.sh $id hisat scallop default A021 >> $summary/match.precision.hisat.scallop
done

exit

./collect.encode10.salmon.sh > $summary/salmon

# collect multi.cuff-exon results with default parameters (for cufflinks)
rm -rf $summary/train.multi.cuff.default
rm -rf $summary/test.multi.cuff.default
for x in `cat $list | head -n 5`
do
	id=`echo $x | cut -f 1 -d ":"`
	./collect.encode10.multi.sh $id scallop.B759.1 cufflinks.default stringtie.2.5 >> $summary/train.multi.cuff.default
done

for x in `cat $list | tail -n 5`
do
	id=`echo $x | cut -f 1 -d ":"`
	./collect.encode10.multi.sh $id scallop.B759.1 cufflinks.default stringtie.2.5 >> $summary/test.multi.cuff.default
done


# collect venn
rm -rf $summary/venn.aligner
rm -rf $summary/venn.algo
for x in `cat $list`
do
	id=`echo $x | cut -f 1 -d ":"`
	cat ../results/encode10/$id.venn/aligner.summary >> $summary/venn.aligner
	cat ../results/encode10/$id.venn/algo.summary >> $summary/venn.algo
done


# collect class results with zero parameters
rm -rf $summary/train.class.zero
rm -rf $summary/test.class.zero

for x in `cat $list | head -n 5`
do
	id=`echo $x | cut -f 1 -d ":"`
	./collect.encode10.class.sh $id scallop.B759.0.01 stringtie.0.01 transcomb.0.01 >> $summary/train.class.zero
done

for x in `cat $list | tail -n 5`
do
	id=`echo $x | cut -f 1 -d ":"`
	./collect.encode10.class.sh $id scallop.B759.0.01 stringtie.0.01 transcomb.0.01 >> $summary/test.class.zero
done

cat $summary/train.class.zero | sort -k1,1n -k2,2 > xxx; mv xxx $summary/train.class.zero
cat $summary/test.class.zero | sort -k1,1n -k2,2 > xxx; mv xxx $summary/test.class.zero


# collect single-exon results with default parameters
rm -rf $summary/train.single.default
rm -rf $summary/test.single.default

for x in `cat $list | head -n 5`
do
	id=`echo $x | cut -f 1 -d ":"`
	./collect.encode10.single.sh $id scallop.B759.1 stringtie.2.5 transcomb.0.01 >> $summary/train.single.default
done

for x in `cat $list | tail -n 5`
do
	id=`echo $x | cut -f 1 -d ":"`
	./collect.encode10.single.sh $id scallop.B759.1 stringtie.2.5 transcomb.0.01 >> $summary/test.single.default
done


# collect quant-results with zero parameters
for ll in `echo "1 2 3"`
do
	outfile=$summary/train.quant$ll.zero
	rm -rf $outfile
	for x in `cat $list | head -n 5`
	do
		id=`echo $x | cut -f 1 -d ":"`
		./collect.encode10.quant.sh $id scallop.B759.0.01 stringtie.0.01 transcomb.0.01 $ll >> $outfile
	done
done

for ll in `echo "1 2 3"`
do
	outfile=$summary/test.quant$ll.zero
	rm -rf $outfile
	for x in `cat $list | tail -n 5`
	do
		id=`echo $x | cut -f 1 -d ":"`
		./collect.encode10.quant.sh $id scallop.B759.0.01 stringtie.0.01 transcomb.0.01 $ll >> $outfile
	done
done




# collect results for ROC
for x in `cat $list`
do
	id=`echo $x | cut -f 1 -d ":"`
	./collect.encode10.roc.sh $id scallop.B759 stringtie transcomb > $summary/$id
done


# collect results for time
rm -rf $summary/time
for x in `cat $list`
do
	id=`echo $x | cut -f 1 -d ":"`
	./collect.encode10.time.sh $id scallop.B759 stringtie transcomb >> $summary/time
done

