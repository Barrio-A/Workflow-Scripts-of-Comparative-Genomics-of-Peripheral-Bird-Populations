#!/bin/bash

ref=bLanMin1.curated_primary.no_mt.scrubbed.fa
pth_anc=$ref
bedfile=repeats.Lm.negative_format.SUPER.bed
threads=8
min_depth=6
max_depth=101

angsd/angsd \
     -GL 3 \
     -out LmR_angsd \
     -nThreads $threads \
     -doSaf 1 \
     -anc $pth_anc \
     -ref $ref \
     -rf $bedfile \
     -C 50 \
     -baq 1 \
     -minMapQ 20 \
     -minQ 20 \
     -uniqueOnly 1 \
     -remove_bads 1 \
     -only_proper_pairs 1 \
     -setMinDepth $min_depth \
     -setMaxDepth $max_depth \
     -doCounts 1 \
     -bam LmR.bamlist.txt
