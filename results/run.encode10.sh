#!/bin/bash

add=""
dir=`pwd`
coralsrc=/home/mxs2589/shao/project/scallop/src
bin=$dir/../programs
list=$dir/../data/encode10.list
datadir=$dir/../data/encode10$add
results=$dir/../results/encode10$add
pbs="pbs"$add
mkdir -p $results

function make.scripts
{
	algo=$1;
	tag=$2;
	coverage=$3
	exe=$bin/$algo

	pbsdir=$dir/$pbs.$tag
	mkdir -p $pbsdir

	if [ "$algo" == "coral" ]; then
		cp $coralsrc/scallop $bin/coral-$tag
		exe=$bin/coral-$tag
	fi
	
	aligns="star hisat"

	if [ "$add" == "-gtf" ]; then
		aligns="star"
	fi

#aligns="hisat"

	for x in `cat $list`
	do
		id=`echo $x | cut -f 1 -d ":"`
		ss=`echo $x | cut -f 2 -d ":"`
		gm=`echo $x | cut -f 3 -d ":"`
		gtf=$dir/../data/ensembl/$gm.gtf
	
		if [ ! -s $gtf ]; then
			echo "make sure $gtf is available"
			exit
		fi

		for aa in `echo $aligns`
		do
	
			cur=$results/$id.$aa/$algo.$tag
			bam=$datadir/$id/$aa.sort.bam
			pbsfile=$pbsdir/$id.$aa.sh

	
			if [ ! -s $bam ]; then
				echo "make sure $bam is available"
				exit
			fi

			echo "#!/bin/bash" > $pbsfile
#echo "#PBS -l nodes=1:ppn=1" >> $pbsfile
#echo "#PBS -l mem=200gb" >> $pbsfile
#echo "#PBS -l walltime=2:00:00" >> $pbsfile
#echo "#PBS -A mxs2589_b_g_sc_default" >> $pbsfile

			echo "$dir/run.$algo.sh $exe $cur $bam $gtf $coverage $ss" >> $pbsfile

			if [ "$algo" == "coral" ]; then
				cur1=$results/$id.$aa/stringtie.$tag
				cur2=$results/$id.$aa/scallop.$tag
				bam1=$cur/coral.sort.bam
				echo "$dir/run.scallop.sh $bin/scallop $cur2 $bam1 $gtf $coverage $ss" >> $pbsfile
				echo "$dir/run.stringtie.sh $bin/stringtie $cur1 $bam1 $gtf $coverage $ss" >> $pbsfile

#cur2=$results/$id.$aa/stringtie.$tag.B
#echo "$dir/run.stringtie.sh $bin/stringtie $cur2 $bam1 $gtf $coverage nostrand" >> $pbsfile
			fi

			chmod +x $pbsfile
		done
	done
}

#tag=`$bin/coral --version`
tag=$1

## MODIFY THE FOLLOWING LINES TO SPECIFIY EXPERIMENTS
#usage: make.scripts <coral|stringtie|transcomb> <ID of this run> <minimum-coverage>
#make.scripts cufflinks test2 999
#make.scripts transcomb test2 0.01
#make.scripts scallop $tag default
#make.scripts stringtie $tag default
make.scripts coral $tag default

pbsdir=$dir/$pbs.$tag
for k in `ls $pbsdir/*.sh`
do
	echo $k
	nohup $k &
done
