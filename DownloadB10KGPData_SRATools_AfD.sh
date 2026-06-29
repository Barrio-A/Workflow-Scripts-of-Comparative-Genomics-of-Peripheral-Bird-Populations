#!/bin/bash

fasterq-dump SRR31371052 --split-files --threads 24

gzip SRR31371052*.fastq

cp SRR31371052_1.fastq.gz LminorB10K_1.fastq.gz
cp SRR31371052_2.fastq.gz LminorB10K_2.fastq.gz

