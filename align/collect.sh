#!/bin/bash

tag="D156"
dir=results.$tag
mkdir -p $dir

nohup ./collect.encode65.3way.sh -a scallop -x $tag -p default > $dir/encode65-scallop &
nohup ./collect.encode65.3way.sh -a stringtie -x $tag -p default > $dir/encode65-stringtie &

nohup ./collect.encode10.3way.sh -a scallop -r star -x $tag -p default > $dir/encode10-000-scallop-star &
nohup ./collect.encode10.3way.sh -a scallop -r hisat -x $tag -p default > $dir/encode10-000-scallop-hisat &
nohup ./collect.encode10.3way.sh -a scallop -r star -x $tag -p default -g > $dir/encode10-gtf-scallop-star &
nohup ./collect.encode10.3way.sh -a stringtie -r star -x $tag -p default > $dir/encode10-000-stringtie-star &
nohup ./collect.encode10.3way.sh -a stringtie -r hisat -x $tag -p default > $dir/encode10-000-stringtie-hisat &
nohup ./collect.encode10.3way.sh -a stringtie -r star -x $tag -p default -g > $dir/encode10-gtf-stringtie-star &
