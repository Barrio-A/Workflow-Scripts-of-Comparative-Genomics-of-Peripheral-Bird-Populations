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


zcat bLanMin_hap1.Repeats.4jb.gff3.gz | cut -f1,4,5 | gzip > repeats_coord.Lm.gff3.gz

cut -f1,2 bLanMin1.curated_primary.no_mt.scrubbed.fa.fai | grep '^scaffold_' > genome.Lm.scaffolds.tsv

zcat repeats_coord.Lm.gff3.gz | \
awk 'BEGIN{OFS="\t"} !/^#/ && $1 ~ /^scaffold_/ {print $1,$2-1,$3}' \
> repeats.Lm.scaffolds.bed
bedtools sort -i repeats.Lm.scaffolds.bed -g genome.Lm.scaffolds.tsv \
> repeats.Lm.scaffolds.sorted.bed
bedtools merge -i repeats.Lm.scaffolds.sorted.bed \
> repeats.Lm.scaffolds.merged.bed
bedtools complement -i repeats.Lm.scaffolds.merged.bed \
-g genome.Lm.scaffolds.tsv \
> repeats.Lm.negative.scaffolds.bed
awk 'BEGIN{OFS=""} {print $1,":",$2+1,"_",$3}' \
repeats.Lm.negative.scaffolds.bed > repeats.Lm.negative_format.scaffolds.bed

cut -f1,2 bLanMin1.curated_primary.no_mt.scrubbed.fa.fai | grep '^SUPER_' > genome.Lm.SUPER.tsv
zcat repeats_coord.Lm.gff3.gz | \
awk 'BEGIN{OFS="\t"} !/^#/ && $1 ~ /^SUPER_/ {print $1,$2-1,$3}' \
> repeats.Lm.SUPER.bed
bedtools sort -i repeats.Lm.SUPER.bed -g genome.Lm.SUPER.tsv \
> repeats.Lm.SUPER.sorted.bed
bedtools merge -i repeats.Lm.SUPER.sorted.bed \
> repeats.Lm.SUPER.merged.bed
bedtools complement -i repeats.Lm.SUPER.merged.bed \
-g genome.Lm.SUPER.tsv \
> repeats.Lm.negative.SUPER.bed
awk 'BEGIN{OFS=""} {print $1,":",$2+1,"_",$3}' \
repeats.Lm.negative.SUPER.bed > repeats.Lm.negative_format.SUPER.bed

samtools coverage LmR.bam > LmR.coverage.txt
samtools depth -a LmR.bam > LmR.depth.tsv

awk -F'\t' '$3 == 0 {count++} END {print count}' LmR.depth.tsv


