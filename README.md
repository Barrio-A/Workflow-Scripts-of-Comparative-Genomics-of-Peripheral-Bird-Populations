---
# Workflow-Scripts-of-Comparative-Genomics-of-Peripheral-Bird-Populations
Bioinformatic workflows for comparative conservation genomics analyses of peripheral, threatened bird populations versus non-threatened populations from same species. Specifically, computational pipelines for genome-wide diversity (π), inbreeding (ROHs &amp; IBDs) and recent demographic history analyses ( SMC++).


## Bioinformatic Workflow
It is only shown one of the two species used for the project (*Lanius minor*). The analyses followed the general computational pipeline below:

---

### 1. Download Data

**Get the RawData, paired-end reads (pair-wise), from the Dataset of Interest (SRR)**
- SRA Toolkit v3.3.0 *(14 threads)*

#!/bin/bash

fasterq-dump SRR31371052 --split-files --threads 24

gzip SRR31371052*.fastq

cp SRR31371052_1.fastq.gz LminorB10K_1.fastq.gz
cp SRR31371052_2.fastq.gz LminorB10K_2.fastq.gz

### 2. Raw sequencing data processing

**First Quality Analysis**
- FastQC v0.12.1 *(12 threads)*

#!/bin/bash
fastqc LminorB10K_1.fastq.gz LminorB10K_2.fastq.gz 12
