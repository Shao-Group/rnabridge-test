#!/bin/bash

tag="D201"
dir=`pwd`

rm -rf jobs.list

./run.encode10.sh $tag xxx xxx
for i in `ls pbs.$tag`
do
	echo $dir/pbs.$tag/$i >> jobs.list
done

./run.encode10.sh $tag.A -gtf xxx
for i in `ls pbs.$tag.A`
do
	echo $dir/pbs.$tag.A/$i >> jobs.list
done

nohup cat jobs.list | xargs -L 1 -I CMD -P 40 bash -c CMD 1> /dev/null 2> /dev/null &

exit

./run.encode10.sh $tag xxx -gtf
for i in `ls pbs-gtf.$tag`
do
	echo $dir/pbs-gtf.$tag/$i >> jobs.list
done

./run.encode10.sh $tag.A -gtf -gtf
for i in `ls pbs-gtf.$tag.A`
do
	echo $dir/pbs-gtf.$tag.A/$i >> jobs.list
done

./run.encode65.sh $tag.A -gtf
for i in `ls pbs65.$tag.A`
do
	echo $dir/pbs65.$tag.A/$i >> jobs.list
done

./run.encode65.sh $tag xxx
for i in `ls pbs65.$tag`
do
	echo $dir/pbs65.$tag/$i >> jobs.list
done

