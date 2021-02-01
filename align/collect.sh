#!/bin/bash

tag="D400"
dir=results.$tag
mkdir -p $dir

./collect.encode10.5way.sh star $dir/encode10.5way.star
./collect.encode10.5way.sh hisat $dir/encode10.5way.hisat

