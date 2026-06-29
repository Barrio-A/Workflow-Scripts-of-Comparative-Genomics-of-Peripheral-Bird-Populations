#!/bin/bash

pth_home=/PATH/DIRECTORY
pth_angsd=/PATH/angsd
pth_i=$pth_home
pth_o=$pth_home/ANGSD_Results
i_name=LmR.bamlist.txt
o_name=LmR_angsd
ref=/PATH/bLanMin1.curated_primary.no_mt.scrubbed.fa
pth_anc=$ref
bedfile=/PATH/repeats.Lm.negative_format.SUPER.bed
threads=8
min_depth=6
max_depth=101

$pth_angsd/angsd \
     -GL 2 \
     -out $pth_o/$o_name \
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
     -bam /PATH/LmR.bamlist.txt
