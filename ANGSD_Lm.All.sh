#!/bin/bash

pth_home=/PATH/DIRECTORY
pth_angsd=/PATH/angsd
pth_i=$pth_home
pth_o=$pth_home/ANGSD_Results
i_name=Lm.bamlist.txt
o_name=Lm_angsd
ref=/PATH/bLanMin1.curated_primary.no_mt.scrubbed.fa
pth_anc=$ref
bedfile=/PATH/repeats.Lm.negative_format.SUPER.bed
threads=8

$pth_angsd/angsd \
     -GL 2 \
     -doGlf 3 \
     -out $pth_o/$o_name \
     -nThreads $threads \
     -doSaf 1 \
     -anc $pth_anc \
     -ref $ref \
     -rf $bedfile \
     -doMajorMinor 1 \
     -doMaf 1 \
     -HWE_pval_F 1 \
     -SNP_pval 1e-6 \
     -doGeno 32 \
     -doPost 1 \
     -doBcf 1 \
     -C 50 \
     -baq 1 \
     -minMapQ 20 \
     -minQ 20 \
     -uniqueOnly 1 \
     -remove_bads 1 \
     -only_proper_pairs 1 \
     -setMinDepth 6 \
     -setMaxDepth 140 \
     -doCounts 1 \
     -bam /PATH/Lm.bamlist.txt
