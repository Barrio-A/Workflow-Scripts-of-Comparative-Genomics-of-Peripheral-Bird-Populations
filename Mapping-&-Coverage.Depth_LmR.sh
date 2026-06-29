#!/bin/bash

gunzip bLanMin1.curated_primary.no_mt.scrubbed.fa.gz

bash bbmerge.sh \
in1=LminorB10K_1.cutadapt.fastq.gz \
in2=LminorB10K_2.cutadapt.fastq.gz \
out=LminorB10K.merged.fq.gz \
outu1=LminorB10K_1.unmerged.fq.gz \
outu2=LminorB10K_2.unmerged.fq.gz \
t=12

samtools faidx bLanMin1.curated_primary.no_mt.scrubbed.fa
bwa index bLanMin1.curated_primary.no_mt.scrubbed.fa

bwa mem \
-t 12 \
-M \
-R "@RG\tID:LmR\tSM:LmR\tPL:illumina\tLB:lib1" \
bLanMin1.curated_primary.no_mt.scrubbed.fa \
LminorB10K_1.unmerged.fq.gz \
LminorB10K_2.unmerged.fq.gz |
samtools view \
-@ 12 \
-Sbh \
-q 20 \
-F 0x100 - > LminorB10K.merged_un.bam

bwa mem \
-t 12 \
-M \
-R "@RG\tID:LmR\tSM:LmR\tPL:illumina\tLB:lib1" \
bLanMin1.curated_primary.no_mt.scrubbed.fa LminorB10K.merged.fq.gz | samtools view \
-@ 12 \
-Sbh \
-q 20 \
-F 0x100 - > LminorB10K.merged.bam

samtools sort -@ 12 -o LminorB10K.merged_un.sorted.bam LminorB10K.merged_un.bam

samtools sort -@ 12 -o LminorB10K.merged.sorted.bam LminorB10K.merged.bam

picard MergeSamFiles \
I=LminorB10K.merged_un.sorted.bam \
I= LminorB10K.merged.sorted.bam \
SO=coordinate \
USE_THREADING=true \
O=LmR.picard.merged.bam

picard MarkDuplicates \
REMOVE_DUPLICATES=true \
I=LmR.picard.merged.bam \
O=LmR.picard.merged.dedup.bam \
M=LmR.picard.merged.mark_duplicates_report.txt \
VALIDATION_STRINGENCY=SILENT

samtools sort -@12 LmR.picard.merged.dedup.bam -o LmR.bam

samtools coverage LmR.bam > LmR.coverage.txt
samtools depth -a LmR.bam > LmR.depth.tsv

awk -F'\t' '$3 == 0 {count++} END {print count}' LmR.depth.tsv


