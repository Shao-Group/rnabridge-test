#!/bin/bash

tag="D156"
dir=results.$tag
mkdir -p $dir

nohup ./collect.encode65.sh -a scallop -x $tag -p default > $dir/encode65-scallop-0 &
nohup ./collect.encode65.sh -a stringtie -x $tag -p default > $dir/encode65-stringtie-0 &
nohup ./collect.encode65.sh -a scallop -x $tag.A -p default > $dir/encode65-scallop-A &
nohup ./collect.encode65.sh -a stringtie -x $tag.A -p default > $dir/encode65-stringtie-A &

nohup ./collect.encode10.sh -a scallop -r star -x $tag -p default > $dir/encode10-000-scallop-star-0 &
nohup ./collect.encode10.sh -a scallop -r hisat -x $tag -p default > $dir/encode10-000-scallop-hisat-0 &
nohup ./collect.encode10.sh -a scallop -r star -x $tag.A -p default > $dir/encode10-000-scallop-star-A &
nohup ./collect.encode10.sh -a scallop -r hisat -x $tag.A -p default > $dir/encode10-000-scallop-hisat-A &
nohup ./collect.encode10.sh -a scallop -r star -x $tag -p default -g > $dir/encode10-gtf-scallop-star-0 &
nohup ./collect.encode10.sh -a scallop -r star -x $tag.A -p default -g > $dir/encode10-gtf-scallop-star-A &
nohup ./collect.encode10.sh -a stringtie -r star -x $tag -p default > $dir/encode10-000-stringtie-star-0 &
nohup ./collect.encode10.sh -a stringtie -r hisat -x $tag -p default > $dir/encode10-000-stringtie-hisat-0 &
nohup ./collect.encode10.sh -a stringtie -r star -x $tag.A -p default > $dir/encode10-000-stringtie-star-A &
nohup ./collect.encode10.sh -a stringtie -r hisat -x $tag.A -p default > $dir/encode10-000-stringtie-hisat-A &
nohup ./collect.encode10.sh -a stringtie -r star -x $tag -p default -g > $dir/encode10-gtf-stringtie-star-0 &
nohup ./collect.encode10.sh -a stringtie -r star -x $tag.A -p default -g > $dir/encode10-gtf-stringtie-star-A &
