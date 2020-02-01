#!/bin/bash

list=./encode50.list
data=./encode50/

mkdir -p $data

for x in `cat $list`
do
	id=`echo $x | cut -f 1 -d ":"`
	url="https://www.encodeproject.org/files/$id/@@download/$id.bam"
	wget $url -O $data/$id.bam
done
