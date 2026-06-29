#!/bin/bash

fastqc LminorB10K_1.fastq.gz LminorB10K_2.fastq.gz 12

fastp \
-i LminorB10K_1.fastq.gz \
-I LminorB10K_2.fastq.gz \
-o LminorB10K_1.fastp.fastq.gz \
-O LminorB10K_2.fastp.fastq.gz \
--detect_adapter_for_pe \
--cut_tail \
--cut_mean_quality 20 \
--length_required 50 \
-w 12 \
-h fastp.html

fastqc LminorB10K_1.fastp.fastq.gz LminorB10K_2.fastp.fastq.gz 12

cutadapt \
-j 12 \
-q 20 \
-m 50 \
-o LminorB10K_1.cutadapt.fastq.gz \
-p LminorB10K_2.cutadapt.fastq.gz \
LminorB10K_1.fastp.fastq.gz \
LminorB10K_2.fastp.fastq.gz

fastqc LminorB10K_1.cutadapt.fastq.gz LminorB10K_2.cutadapt.fastq.gz 12
