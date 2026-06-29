#!/bin/bash

vcf="Lanius_minor.vcf.gz"
tabix "$vcf"


smc++ vcf2smc \
    -l 160401690 \
    "$vcf"\
     LmR.smc.gz \
    SUPER_1 \
    pop1:LmR.bam

smc++ vcf2smc \
    -l 160401690 \
    "$vcf" \
    LmV.smc.gz \
    SUPER_1 \
    pop2:LmV.bam



smc++ estimate \
    --cores 8 \
    -w 100 \
    --base rusia \
    -o rusia/ \
    4.6e-9  \
    LmV.smc.gz

smc++ estimate \
    --cores 8 \
    -w 100 \
    --base vallcalent \
    -o vallcalent/ \
    4.6e-9  \
    LmV.smc.gz



smc++ vcf2smc \
    "$vcf" \
    LmR.LmS.smc.gz \
    SUPER_1 \
    pop1:LmR.bam \
    pop2:LmV.bam

smc++ vcf2smc \
    "$vcf" \
    LmS.LmB.smc.gz \
    SUPER_1 \
    pop2:LmV.bam \
    pop1:LmR.bam



smc++ split \
    -o split_lanius/ \
    rusia/rusia.final.json \
    vallcalent/vallcalent.final.json \
    LmR.smc.gz \
    LmV.smc.gz
