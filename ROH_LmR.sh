#!/bin/bash

rohan \
    --rohmu 2e-5 \
    --auto autosomes \
    --size 1000000 \
    -t 24 \
    --map repeats.Lm.negative_format.SUPER.bed \
    -o LmR.rhomu2e5.1m.rohan \
    bLanMin1.curated_primary.no_mt.scrubbed.fa \
    LmR.bam
