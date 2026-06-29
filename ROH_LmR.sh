#!/bin/bash

rohan \
    --rohmu 2e-5 \
    --auto autosomes \
    --size 1000000 \
    -t 24 \
    --map Lm.mask.bed \
    -o LmR.rhomu2e5.1m.rohan \
    /PATH/bLanMin1.curated_primary.no_mt.scrubbed.fa \
    /PATH/LmR.bam
