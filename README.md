# Overview

This repository tests the performance of
[**Coral**](https://github.com/Shao-Group/coral) in improving transcript assembly.
Here we provide scripts to download datasets, run Coral and downstream assemblers,
and reproduce the results and figures in the manuscript (submitted).

The pipeline involves in the followint four steps:

1. Download necessary datasets (`data` directory).
2. Download and/or compile necessary programs (`programs` directory).
3. Run the methods to produce results (`results` directory).
4. Summarize results and produce figures (`plots` directory).

# Datasets
We evaluate Coral on three datasets, namely **encode10**, **encode50**, and **gtex**
(the GTEx dataset is restricted so we do not publish here). 
Besides, we also need the annotation files for evaluation purposes.
In directory `data`, we provide metadata for these datasets, and also provide scripts to download them.

## **encode10**
The first dataset, namely **encode10**,
contains 10 human RNA-seq samples downloaded from ENCODE.
This dataset has also been used in [scalloptest](https://github.com/Kingsford-Group/scalloptest).
All these samples are sequenced with strand-specific and paired-end protocols.
For each of these 10 samples, we align it with two RNA-seq aligners,
[STAR](https://github.com/alexdobin/STAR) and
[HISAT2](https://ccb.jhu.edu/software/hisat2/index.shtml).
You may download all these reads alignments via
[Penn State Data Commons](https://doi.org/10.26208/8c06-w247).

## **encode50**
The second dataset, namely **encode50**,
contains 50 human RNA-seq samples downloaded from ENCODE.
This dataset includes 50 strand-specific samples and 15 non-strand samples.
These samples have pre-computed reads alignments, and can be downloaded by the script in `data` directory.
```
./download.encode50.sh
```
The downloaded files will appear under `data/encode50`.

## Annotations
For **encode10** and **encode50** datasets, we use human annotation database as reference;
Use the following script in `data` to download annotations:
```
./download.annotation.sh
```
The downloaded files will appear under `data/ensembl`.


# Programs

Our experiments (used in the manuscript) involve the following four programs:

Program | Version | Description
------------ | ------------ | ------------ 
[Coral](https://github.com/Shao-Group/coral) | v1.0.0 | Transcript assembler
[Scallop](https://github.com/Kingsford-Group/scallop) | v0.10.4 | Transcript assembler
[StringTie](https://ccb.jhu.edu/software/stringtie/) | v1.3.5 | Transcript assembler
[gffcompare](http://ccb.jhu.edu/software/stringtie/gff.shtml) | v0.11.2 | Evaluate assembled transcripts
[gtfcuff](https://github.com/Kingsford-Group/rnaseqtools) |  | RNA-seq tool

You need to download and/or complile them,
and then link them to `programs` directory.
Make sure that the program names are in lower cases (i.e., `coral`, `stringtie`, `scallop`, and `gffcompare`)
in `programs` directory.

# Run the Methods

Once the datasets and programs are all available, use the following scripts in `results`
to run the methods assemblers on the datasets:
```
./run.encode10.sh
./run.encode50.sh
```
In each of these three scripts, you can modify it to run different parameters.
For each run, you need to specify a `run-id`, which will be used later on when
collecting the results. 


# Analysis Results and Reproduce Figures

Once the results have been generated, one can use the following scripts in `plots` to reproduce the figures:
```
./build.figures.sh
```
You may need to install R `tikzDevice`.
You may also need to modify these scripts to match the `run-id(s)` you specified..
