#!/bin/bash

bcftools view Lm_angsd.bcf -Ov -o Lanius_minor.vcf

sort -k2,2nr bLanMin1.curated_primary.no_mt.scrubbed.fa.fai | head

bgzip -c Lanius_minor.vcf > Lanius_minor.vcf.gz

bcftools index Lanius_minor.vcf.gz
