# Overview

This repository tests the performance of 
[**rnabridge-align**](https://github.com/Shao-Group/rnabridge-align) and
[**rnabridge-denovo**](https://github.com/Shao-Group/rnabridge-denovo).
Here we provide scripts to download datasets, run these tools
and reproduce the results and figures in the manuscript.

The pipeline involves in the followint five steps:

1. Download necessary datasets (`data` directory).
2. Download and/or compile necessary programs (`programs` directory).
3. Run the methods and produce results regarding `rnabridge-align` (`align` directory).
4. Run the methods and produce results regarding `rnabridge-denovo` (`denovo` directory).
5. Summarize results and produce figures (`plots` directory).

# Datasets
We evaluate them on two datasets, namely simulation80 and encode10.
We also need the reference annotation files for evaluating reference-based transcript assembly.
In directory `data`, we provide metadata for these datasets, and also provide scripts to download them.

## **simulation80**
To be available via Penn State Data Commons.

## **encode10**
This dataset contains 10 human RNA-seq samples downloaded from ENCODE.
This dataset has also been used in [scalloptest](https://github.com/Kingsford-Group/scalloptest).
All these samples are sequenced with strand-specific and paired-end protocols.
For each of these 10 samples, we align it with two RNA-seq aligners,
[STAR](https://github.com/alexdobin/STAR) and
[HISAT2](https://ccb.jhu.edu/software/hisat2/index.shtml).
You may download all these reads alignments via
[Penn State Data Commons](https://doi.org/10.26208/8c06-w247).

## annotations
Use the following script in `data` to download annotations:
```
./download.annotation.sh
```
The downloaded files will appear under `data/ensembl`.

# Programs

Our experiments (used in the manuscript) involve the following four programs:

Program | Version | Description
------------ | ------------ | ------------ 
[rnabridge-align](https://github.com/Shao-Group/rnabridge-align) | v1.0.1| bridging RNA-seq alignments
[Scallop](https://github.com/Kingsford-Group/scallop) | v0.10.5 | transcript assembler
[StringTie](https://ccb.jhu.edu/software/stringtie/) | v2.1.4 | transcript assembler
[gffcompare](http://ccb.jhu.edu/software/stringtie/gff.shtml) | v0.11.2 | Evaluate assembled transcripts
[gtfcuff](https://github.com/Kingsford-Group/rnaseqtools) |  | a set of utilities for processing RNA-seq data

You need to download and/or complile them, and then link them to `programs` directory.
Make sure that the program names are in lower cases (i.e., `stringtie`, `scallop`, and `gffcompare`) in `programs` directory.

# Generate Results for Evaluating rnabridge-align

Once the datasets and programs are available, use the following scripts in `align` to run:
```
./run.simulation80.sh
./run.encode10.sh
```
In each of these scripts, you can modify it to run different parameters.
For each run, you need to specify a `run-id`, which will be used later on when
collecting the results. 

After experiments finish running, the following script can collect accuracies:
```
./collect.sh
```
This will report results to a directory `results.RUN-ID`, which can be directly
use by the scripts to generate figreus (below).

# Analysis Results and Reproduce Figures

Once the results have been generated, one can use the following scripts in `plots` to reproduce the figures:
```
./build.figures.sh
```
You may need to install R `tikzDevice`.  You may also need to modify these scripts to match the `run-id(s)` you specified.
#The results used in the manuscript (run-id = D400) has been update in this repo (including GTEx dataset),
#so the directly running above script can generate all figures used in the manuscript.
