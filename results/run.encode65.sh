#!/bin/bash

dir=`pwd`
bin=$dir/../programs
list=$dir/../data/encode65.list
datadir=$dir/../data/encode65
results=$dir/../results/encode65
coralsrc=/storage/home/m/mxs2589/group/projects/coral/src
mkdir -p $results

function make.scripts
{
	algo=$1;
	tag=$2;
	coverage=$3;
	exe=$bin/$algo

	pbsdir=$dir/pbs.$tag
	mkdir -p $pbsdir

	if [ "$algo" == "coral" ]; then
		cp $coralsrc/coral $bin/coral-$tag
		exe=$bin/coral-$tag
	fi
	
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
	
		bam=$datadir/$id.bam
	
		if [ ! -s $bam ]; then
			echo "make sure $bam is available"
			exit
		fi

		cur=$results/$id/$algo.$tag
		pbsfile=$pbsdir/$id.pbs

		echo "#!/bin/bash" > $pbsfile
		echo "#PBS -l nodes=1:ppn=1" >> $pbsfile
		echo "#PBS -l mem=200gb" >> $pbsfile
		echo "#PBS -l walltime=3:00:00" >> $pbsfile
		echo "#PBS -A mxs2589_b_g_sc_default" >> $pbsfile
		echo "$dir/run.$algo.sh $exe $cur $bam $gtf $coverage $ss" >> $pbsfile

		if [ "$algo" == "coral" ]; then
			cur1=$results/$id/stringtie.$tag
			cur2=$results/$id/stringtie.$tag
			bam1=$cur/coral.sort.bam
			echo "$dir/run.stringtie.sh $bin/stringtie $cur1 $bam1 $gtf $coverage nostrand" >> $pbsfile
			echo "$dir/run.stringtie.sh $bin/stringtie $cur2 $bam1 $gtf $coverage $ss" >> $pbsfile
		fi
	done
}

tag=$1
## MODIFY THE FOLLOWING LINES TO SPECIFIY EXPERIMENTS
#usage: make.scripts <coral|stringtie|transcomb> <ID of this run> <minimum-coverage>
#make.scripts stringtie test3 0.01
#make.scripts stringtie $tag default
make.scripts coral $tag default
