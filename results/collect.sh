#!/bin/bash
nohup ./collect.encode65.sh -a scallop -x D131 -p default > results.D131/encode65-scallop &
nohup ./collect.encode65.sh -a stringtie -x D131 -p default > results.D131/encode65-stringtie &

nohup ./collect.encode10.sh -a scallop -r star -x D131 -p default > results.D131/encode10-000-scallop-star-0 &
nohup ./collect.encode10.sh -a scallop -r hisat -x D131 -p default > results.D131/encode10-000-scallop-hisat-0 &
nohup ./collect.encode10.sh -a scallop -r star -x D131.A -p default > results.D131/encode10-000-scallop-star-A &
nohup ./collect.encode10.sh -a scallop -r hisat -x D131.A -p default > results.D131/encode10-000-scallop-hisat-A &
nohup ./collect.encode10.sh -a scallop -r star -x D131 -p default -g > results.D131/encode10-gtf-scallop-star-0 &
nohup ./collect.encode10.sh -a scallop -r star -x D131.A -p default -g > results.D131/encode10-gtf-scallop-star-A &
nohup ./collect.encode10.sh -a stringtie -r star -x D131 -p default > results.D131/encode10-000-stringtie-star-0 &
nohup ./collect.encode10.sh -a stringtie -r hisat -x D131 -p default > results.D131/encode10-000-stringtie-hisat-0 &
nohup ./collect.encode10.sh -a stringtie -r star -x D131.A -p default > results.D131/encode10-000-stringtie-star-A &
nohup ./collect.encode10.sh -a stringtie -r hisat -x D131.A -p default > results.D131/encode10-000-stringtie-hisat-A &
nohup ./collect.encode10.sh -a stringtie -r star -x D131 -p default -g > results.D131/encode10-gtf-stringtie-star-0 &
nohup ./collect.encode10.sh -a stringtie -r star -x D131.A -p default -g > results.D131/encode10-gtf-stringtie-star-A &
